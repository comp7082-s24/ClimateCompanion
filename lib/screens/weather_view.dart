import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class WeatherView extends StatelessWidget {
  const WeatherView({super.key, required final GoRouterState goRouterState});

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: const Text("Toggle Theme"),
          ),
          const SizedBox(height: 16),
          const Text("This is a sample text."),
        ],
      ),
    );
  }
}
