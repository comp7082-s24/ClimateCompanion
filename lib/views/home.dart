import "package:climate_companion/navigation/app_navigation.dart";
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "../components/appbar.dart";
import "../themes/theme_provider.dart";
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: const MainAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    // context.pushNamed(context.namedLocation("Profile"));

                  },
                  child: const Text("Toggle Theme"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(RoutePath.suggestions.name);
                  },
                  /// TODO Implement the suggestions
                  child: const Text("Go to Suggestions"),
                ),
                const SizedBox(height: 16),
                const Text("HomePage"),
              ],
            )
            ),
    );
  }
}
