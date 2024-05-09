import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:weather/weather.dart";

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
  WeatherFactory wf =
      WeatherFactory("587ea169202f172133a2f44d973687f1", language: Language.ENGLISH);
  late Weather w;
  late List<Weather> forecast;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Weather>> fetchNextFiveDays() async {
    return await wf.fiveDayForecastByCityName("Burnaby");
  }

  // Asynchronous method to fetch weather data
  Future<Weather> fetchWeather() async {
    return await wf.currentWeatherByCityName("Burnaby");
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(),
          const SizedBox(height: 16),
          _buildWeatherView(),
          const SizedBox(height: 16),
          _nextDaysText(),
          const SizedBox(height: 16),
          FutureBuilder(future: fetchNextFiveDays(), builder: (final BuildContext context, final AsyncSnapshot<List<Weather>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              forecast = snapshot.data!;
              print(forecast);
              return UpcomingBox(entries: entries, context: context, forecast: forecast);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },),
        ],
      ),
    );
  }

  FutureBuilder<Weather> _buildWeatherView() {
    return FutureBuilder(
      future: fetchWeather(),
      builder: (final BuildContext context, final AsyncSnapshot<Weather> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          w = snapshot.data!;
          return MainWeatherContainer(
              degrees: "${w.tempFeelsLike?.celsius?.toStringAsFixed(1)} Degrees",
              weatherIcon: weatherIcon,
              weather: w.weatherDescription.toString(),
              link: "http://openweathermap.org/img/w/${w.weatherIcon}.png");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
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

class UpcomingBox extends StatelessWidget {
  const UpcomingBox({
    super.key,
    required this.entries,
    required this.context,
    required this.forecast,
  });

  final List<String> entries;
  final BuildContext context;
  final List<Weather> forecast;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (final BuildContext context, final int index) {
          return Builder(
              // Created a builder to fetch the latest theme
              builder: (final context) {
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
                      "Day",
                      style: TextStyle(
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
                ));
          });
        },
        separatorBuilder: (final BuildContext context, final int index) {
          return SizedBox(width: MediaQuery.of(context).size.width / 18);
        },
      ),
    );
  }
}

class MainWeatherContainer extends StatelessWidget {
  const MainWeatherContainer(
      {super.key,
      required this.degrees,
      required this.weatherIcon,
      required this.weather,
      required this.link});

  final String degrees;
  final Icon weatherIcon;
  final String weather;
  final String link;

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
          Image.network(
            link,
            fit: BoxFit.cover,
            height: 64,
          ),
          // Icon(
          //   weatherIcon.icon,
          //   size: 64,
          //   color: Colors.blue,
          // ),
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
