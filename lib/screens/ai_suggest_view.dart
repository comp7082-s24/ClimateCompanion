import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:go_router/go_router.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weather/weather.dart";
import "package:flutter_gemini/src/models/candidates/candidates.dart";

class ActivityList {
  final List<Activity> activities;

  ActivityList({required this.activities});

  factory ActivityList.fromJson(final List<dynamic> json) {
    final List<Activity> activities = json.map((final activity) => Activity.fromJson(activity as Map<String, dynamic>)).toList();
    return ActivityList(activities: activities);
  }
}

class Activity {
  final String title;
  final String description;

  Activity({required this.title, required this.description});

  factory Activity.fromJson(final Map<String, dynamic> json) {
    return Activity(
      title: json["title"] as String,
      description: json["description"] as String,
    );
  }
}

class AiSuggestView extends StatefulWidget {
  const AiSuggestView({
    super.key,
    required this.goRouterState,
  });

  final GoRouterState goRouterState;

  @override
  State<AiSuggestView> createState() => _AiSuggestViewState();
}

class _AiSuggestViewState extends State<AiSuggestView> {
  late Future<Candidates?> fetchCandidatesFuture;
  late final Weather weather;
  late ActivityList _activities;

  @override
  void initState() {
    super.initState();

    weather = widget.goRouterState.extra as Weather;

    final prompt = "Give me a list of 3 of activities to do in ${weather.areaName} located in Country Code (${weather.country}) when the "
        "weather is "
        "${weather.weatherDescription}. Return the response as a json object containing a title and a description";

    fetchCandidatesFuture = Gemini.instance.text(prompt);

    fetchCandidatesFuture.then((final value) {
      final String jsonString = value?.content?.parts?.first.text?.replaceFirst("```json\n{", "{").replaceFirst("}\n```", "}") ?? "";
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final List<dynamic> activityListJson = jsonData["activities"] as List<dynamic>;

      setState(() {
        _activities = ActivityList.fromJson(activityListJson);
      });
    });
  }

  Future<void> saveFavorite(final Activity activity) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteActivities = prefs.getStringList("favorites") ?? [];
    final Map<String, dynamic> favoriteActivity = {
      "title": activity.title,
      "description": activity.description,
      "weatherDescription": weather.weatherDescription,
    };
    favoriteActivities.add(jsonEncode(favoriteActivity));
    await prefs.setStringList("favorites", favoriteActivities);
  }

  void _reSuggest() {
    setState(() {
      final prompt = "Give me a list of another 3 of activities to do in ${weather.areaName} located in Country Code (${weather.country}) "
          "when the "
          "weather is "
          "${weather.weatherDescription}. Return the response as a json object containing a title and a description";
      fetchCandidatesFuture = Gemini.instance.text(prompt);

      fetchCandidatesFuture.then((final value) {
        final String jsonString = value?.content?.parts?.first.text?.replaceFirst("```json\n{", "{").replaceFirst("}\n```", "}") ?? "";
        final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
        final List<dynamic> activityListJson = jsonData["activities"] as List<dynamic>;
        _activities = ActivityList.fromJson(activityListJson);
      });
    });
  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder(
      future: fetchCandidatesFuture,
      builder: (
        final BuildContext context,
        final AsyncSnapshot<Candidates?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return _buildAiSuggestView(snapshot.data!);
        }
      },
    );
  }

  Widget _buildAiSuggestView(final Candidates c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            c.output != null
                ? Text(
                    "Here are some activities you can do in ${weather.areaName} with the weather being ${weather.temperature}:",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            ..._activities.activities.map(
              (final activity) => ListTile(
                title: Text(
                  activity.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(activity.description),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite_outline),
                  onPressed: () async {
                    await saveFavorite(activity);
                    showDialog<void>(
                      context: context,
                      builder: (final BuildContext context) {
                        return const AlertDialog(
                          title: Text("Suggestion Saved Successfully."),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Didn't like the suggestions? Try again!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(onPressed: _reSuggest, child: const Text("Re-Suggest")),
            ),
          ],
        ),
      ),
    );
  }
}
