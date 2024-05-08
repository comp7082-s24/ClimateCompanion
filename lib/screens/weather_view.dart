import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class WeatherView extends StatefulWidget {
  const WeatherView({super.key, required final GoRouterState goRouterState});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final String degrees = "Weather";
  final Icon weatherIcon = const Icon(Icons.cloud);
  final String weather = "Cloudy AF";
  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(),
          const SizedBox(height: 16),
          _weatherContainer(degrees: degrees, weatherIcon: weatherIcon, weather: weather),
          const SizedBox(height: 16),
          _nextDaysText(),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (final BuildContext context, final int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        offset: Offset(6, 6),
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Cloudy",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.cloud,
                        size: 24,
                        color: Colors.blue,
                      ),
                      Text(
                        entries[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                );
              },
              separatorBuilder: (final BuildContext context, final int index) {
                return SizedBox(width: MediaQuery.of(context).size.width / 18);
              },
            ),
          ),

          // const SizedBox(height: 16),
          // const Text("This is a sample text."),
        ],
      ),
    );
  }

  Text _nextDaysText() {
    return const Text(
      "The Next 3 Days...",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _title() {
    return const Text(
      "Greetings Charlie!",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _weatherContainer extends StatelessWidget {
  const _weatherContainer({
    super.key,
    required this.degrees,
    required this.weatherIcon,
    required this.weather,
  });

  final String degrees;
  final Icon weatherIcon;
  final String weather;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(6, 6),
            color: Colors.black26,
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            degrees,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            weatherIcon.icon,
            size: 64,
            color: Colors.blue,
          ),
          Text(
            weather,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed("aiSuggest");
            },
            child: const Text("CC, What are my options?"),
          ),
        ],
      ),
    );
  }
}
