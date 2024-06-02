import "package:climate_companion/state/app_state_provider.dart";
import "package:climate_companion/utils/strings.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:weather/weather.dart";

class WeatherView extends StatefulWidget {
  const WeatherView({super.key, required final GoRouterState goRouterState});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final String degrees = "Weather";
  final Icon weatherIcon = const Icon(Icons.cloud);
  final List<String> entries = <String>["A", "B", "C"];
  WeatherFactory wf = WeatherFactory(const String.fromEnvironment("OPENWKEY"));
  late Weather w;
  late List<Weather> forecast;
  late List<Weather> nextFiveDays;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Weather>> fetchNextFiveDays() async {
    final List<Weather> data = await wf.fiveDayForecastByCityName("Burnaby");
    final Map<String, Weather> weatherByDay = {};
    for (final Weather w in data) {
      // Only grabs the first weather data for each day at 2 am
      if (!weatherByDay.containsKey(w.date!.day.toString())) {
        weatherByDay[w.date!.day.toString()] = w;
      }
    }
    return weatherByDay.values.toList();
  }

  List<Weather> fetchFiveDays(final List<Weather> data) {
    return nextFiveDays;
  }

  // Asynchronous method to fetch weather data
  Future<Weather> fetchWeather() async {
    return await wf.currentWeatherByCityName("Burnaby");
  }

  @override
  Widget build(final BuildContext context) {
    final name = Provider.of<AppStateProvider>(context).name ?? "";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(name),
          const SizedBox(height: 16),
          _buildWeatherView(),
          const SizedBox(height: 16),
          _nextDaysText(),
          const SizedBox(height: 16),
          _buildThreeDays(),
        ],
      ),
    );
  }

  Text _title(final String name) {
    return Text(
      "Greetings $name!",
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
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
            degrees: "${w.tempFeelsLike?.celsius?.toStringAsFixed(1)} °C",
            weather: w.weatherDescription.toString().toTitleCase(),
            link: fetchWeatherIcon(w.weatherIcon!),
            w: w,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Text _nextDaysText() {
    return const Text(
      "The Next Few Days...",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  FutureBuilder<List<Weather>> _buildThreeDays() {
    return FutureBuilder(
      future: fetchNextFiveDays(),
      builder: (final BuildContext context, final AsyncSnapshot<List<Weather>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          forecast = snapshot.data!;
          return UpcomingBox(forecast: forecast);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class UpcomingBox extends StatelessWidget {
  const UpcomingBox({
    super.key,
    required this.forecast,
  });

  final List<Weather> forecast;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: 5,
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
                    Text(
                      "${forecast[index].tempFeelsLike!.celsius!.toStringAsFixed(1)}°C",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.network(
                      fetchWeatherIcon(forecast[index].weatherIcon!),
                      fit: BoxFit.cover,
                      height: 32,
                    ),
                    Text(
                      "${forecast[index].date?.month}/${forecast[index].date?.day}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        separatorBuilder: (final BuildContext context, final int index) {
          return SizedBox(width: MediaQuery.of(context).size.width / 18);
        },
      ),
    );
  }
}

class MainWeatherContainer extends StatelessWidget {
  const MainWeatherContainer({
    super.key,
    required this.degrees,
    required this.weather,
    required this.link,
    required this.w,
  });

  final String degrees;
  final String weather;
  final String link;
  final Weather w;

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
          Text(
            weather,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pushNamed("aiSuggest", extra: w);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text("CC, What are my options?"),
          ),
        ],
      ),
    );
  }
}
