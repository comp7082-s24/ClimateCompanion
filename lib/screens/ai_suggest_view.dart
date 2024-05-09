import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:go_router/go_router.dart";
import "package:weather/weather.dart";
import "package:flutter_gemini/src/models/candidates/candidates.dart";

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

  @override
  void initState() {
    super.initState();

    weather = widget.goRouterState.extra as Weather;

    final prompt = "Give me a list of 3 of activities to do in ${weather.areaName} located in Country Code (${weather.country}) when the "
        "weather is "
        "${weather.weatherDescription}. Format the text.";

    fetchCandidatesFuture = Gemini.instance.text(prompt);
  }

  void _reSuggest() {
    setState(() {
      fetchCandidatesFuture = Gemini.instance
          .text("I didn't like those suggestions. Give me another list of 3 of activities to do in ${weather.areaName} located in Country "
              "Code (${weather.country}) when the weather is ${weather.weatherDescription}. Format the text.");
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
            Text(
              c.output ?? "No suggestions found.",
              style: Theme.of(context).textTheme.bodySmall,
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
