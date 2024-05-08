import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class WeatherView extends StatelessWidget {
  const WeatherView({super.key, required final GoRouterState goRouterState});

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _title(),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(4),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "20 Degrees",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.cloud,
                  size: 64,
                  color: Colors.blue,
                ),
                Text(
                  "Cloudy AF",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
               ElevatedButton(onPressed: () {
               }, child: const Text("CC, What are my options?"))
              ],
            ),
          ),
          // const SizedBox(height: 16),
          // const Text("This is a sample text."),
        ],
      ),
    );
  }

  Row _title() {
    return const Row(
      children: [
        Text("Greetings Charlie!",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }
}
