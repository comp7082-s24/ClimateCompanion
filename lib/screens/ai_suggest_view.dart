// ignore: implementation_imports
import "package:climate_companion/components/rounded_container.dart";
import "package:climate_companion/constants.dart";
import "package:climate_companion/navigation.dart";
import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import "package:go_router/go_router.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weather/weather.dart";
import "package:climate_companion/models/acitivty_list.dart";

final ValueNotifier<DateTime> dateUpdateRequested = ValueNotifier<DateTime>(DateTime.now());

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
  ActivityList _activities = ActivityList(activities: []);
  final List<Activity> _selected = [];

  @override
  void initState() {
    super.initState();
    try {
      weather = widget.goRouterState.extra as Weather;
      if (weather.areaName == null || weather.country == null || weather.weatherDescription == null) {
        fetchCandidatesFuture = Future.error("error");
        return;
      }

      final prompt = Constants.prompt(weather.areaName!, weather.country!, weather.weatherDescription!);

      fetchCandidatesFuture = Gemini.instance.text(prompt);

      fetchCandidatesFuture.then((final value) {
        final List<dynamic> activityListJson = parseJsonFromCandidates(value);

        setState(() {
          _activities = ActivityList.fromJson(activityListJson);
        });
      });
    } catch (e) {
      fetchCandidatesFuture = Future.error("error");
      _activities = ActivityList(activities: []);
    }
  }

  List<dynamic> parseJsonFromCandidates(final Candidates? value) {
    final String jsonString = value?.content?.parts?.first.text?.replaceFirst("```json\n{", "{").replaceFirst("}\n```", "}") ?? "";
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> activityListJson = jsonData["activities"] as List<dynamic>;
    return activityListJson;
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
    setState(() {
      _selected.contains(activity) ? _selected.remove(activity) : _selected.add(activity);
      dateUpdateRequested.value = DateTime.now();
    });
  }

  void _reSuggest() {
    setState(() {
      final prompt = Constants.prompt(weather.areaName!, weather.country!, weather.weatherDescription!, isRePrompt: true);
      fetchCandidatesFuture = Gemini.instance.text(prompt);
      fetchCandidatesFuture.then((final value) {
        final List<dynamic> activityListJson = parseJsonFromCandidates(value);
        _activities = ActivityList.fromJson(activityListJson);
      }).catchError((final Object e) {
        fetchCandidatesFuture = Future.error("error");
        _activities = ActivityList(activities: []);
      });
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AiSuggestDestination().title),
      ),
      body: FutureBuilder(
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
      ),
    );
  }

  Widget _buildAiSuggestView(final Candidates c) {
    if (weather.areaName == null || weather.weatherDescription == null) {
      return const Text(Constants.aiSuggestErrorMessage);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            c.output != null
                ? Text(
                    // "Here are some activities you can do in ${weather.areaName} with the weather being ${weather.temperature}:"
                    Constants.aiSuggestHeaderMessage(weather.areaName!, weather.weatherDescription!),
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (final widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  ..._activities.activities.map(
                    _activitySuggestion,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              Constants.aiSuggestRetryMessage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _reSuggest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(Constants.reSuggestButtonTitle, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activitySuggestion(final Activity activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: roundedContainer(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: ListTile(
          title: Text(
            activity.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(activity.description, style: Theme.of(context).textTheme.bodyMedium),
          trailing: IconButton(
            icon: _selected.contains(activity) ? const Icon(Icons.favorite_outlined) : const Icon(Icons.favorite_outline),
            onPressed: () async {
              await saveFavorite(activity);
              if (mounted) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        _selected.contains(activity)
                            ? Constants.suggestionSavedSnackBarMessage
                            : Constants.suggestionRemovedSnackBarMessage,
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
