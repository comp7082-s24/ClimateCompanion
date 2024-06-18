import "package:climate_companion/components/rounded_container.dart";
import "package:climate_companion/state/app_state_provider.dart";
import "package:climate_companion/utils/strings.dart";
import "package:flutter/material.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:weather/weather.dart";
import "package:widget_and_text_animator/widget_and_text_animator.dart";
import "../components/rounded_icon_w_label.dart";

class WeatherView extends StatefulWidget {
  const WeatherView({super.key, required final GoRouterState goRouterState});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final String degrees = "Weather";
  final Icon weatherIcon = const Icon(Icons.cloud);
  WeatherFactory wf = WeatherFactory(const String.fromEnvironment("OPENWKEY"));
  bool isUpcomingDays = true;
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

  Future<List<Weather>> fetchNextFiveHours() async {
    final List<Weather> data = await wf.fiveDayForecastByCityName("Burnaby");
    final Map<String, Weather> weatherByHour = {};
    for (final Weather w in data) {
      // Only grabs the first weather data for each day at 2 am
      if (!weatherByHour.containsKey(w.date!.hour.toString())) {
        weatherByHour[w.date!.hour.toString()] = w;
      }
    }
    return weatherByHour.values.toList();
  }

  // Asynchronous method to fetch weather data
  Future<Weather> fetchWeather() async {
    final w = await wf.currentWeatherByCityName("Burnaby");
    return w;
  }

  @override
  Widget build(final BuildContext context) {
    final name = Provider.of<AppStateProvider>(context).name ?? "";
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title(name),
            const SizedBox(height: 32),
            _buildWeatherView(),
            const SizedBox(height: 32),
            upcomingSection(),
          ],
        ),
      ),
    );
  }

  Column upcomingSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _nextText(),
                isUpcomingDays ? _nextDaysText() : _nextHoursText(),
              ],
            ),
            // isUpcomingDays ? _nextDaysText() : _nextHoursText(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isUpcomingDays = !isUpcomingDays;
                  });
                },
                child: Text(isUpcomingDays ? "H" : "D"),
              ),
            ),
          ],
        ),
        _buildUpcomingBox(),
      ],
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
            // degrees: "${w.tempFeelsLike?.celsius?.toStringAsFixed(1)} °C",
            degrees: "${w.temperature?.celsius?.toStringAsFixed(1)}",
            weather: w.weatherDescription.toString().toTitleCase(),
            link: fetchWeatherIcon(w.weatherIcon!),
            w: w,
          );
        } else {
          return roundedContainer(
            color: Theme.of(context).cardColor,
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  TextAnimator _nextDaysText() {
    return TextAnimator(
      "Days",
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      incomingEffect: WidgetTransitionEffects(
        duration: const Duration(milliseconds: 500),
        offset: const Offset(0, -25),
      ),
      outgoingEffect: WidgetTransitionEffects(
        duration: const Duration(milliseconds: 500),
        offset: const Offset(0, 25),
      ),
    );
  }

  TextAnimator _nextHoursText() {
    return TextAnimator(
      "Hours",
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      incomingEffect: WidgetTransitionEffects(
        duration: const Duration(milliseconds: 500),
        offset: const Offset(0, -25),
      ),
      outgoingEffect: WidgetTransitionEffects(
        duration: const Duration(milliseconds: 500),
        offset: const Offset(0, 25),
      ),
    );
  }

  Text _nextText() {
    return const Text(
      "The Next Few ",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  FutureBuilder<List<Weather>> _buildUpcomingBox() {
    return FutureBuilder(
      future: isUpcomingDays ? fetchNextFiveDays() : fetchNextFiveHours(),
      builder: (final BuildContext context, final AsyncSnapshot<List<Weather>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          forecast = snapshot.data!;
          return UpcomingBox(forecast: forecast, isUpcomingDays: isUpcomingDays);
        } else {
          return const UpcomingBoxLoading();
        }
      },
    );
  }
}

class UpcomingBoxLoading extends StatelessWidget {
  const UpcomingBoxLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (final BuildContext context, final int index) {
          return roundedContainer(
            color: Theme.of(context).cardColor,
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 4,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        separatorBuilder: (final BuildContext context, final int index) {
          return SizedBox(width: MediaQuery.of(context).size.width / 18);
        },
      ),
    );
  }
}

class UpcomingBox extends StatelessWidget {
  const UpcomingBox({
    super.key,
    required this.forecast,
    required this.isUpcomingDays,
  });

  final List<Weather> forecast;
  final bool isUpcomingDays;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: 5,
          itemBuilder: (final BuildContext context, final int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 1500),
                  child: Builder(
                    // Created a builder to fetch the latest theme
                    builder: (final context) {
                      return roundedContainer(
                        color: Theme.of(context).cardColor,
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
                            isUpcomingDays
                                ? Text(
                                    "${forecast[index].date?.month}/${forecast[index].date?.day}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "${forecast[index].date?.hour}:00",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (final BuildContext context, final int index) {
            return SizedBox(width: MediaQuery.of(context).size.width / 18);
          },
        ),
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
    return roundedContainer(
      margin: const EdgeInsets.all(4),
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${w.temperature?.celsius?.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 94,
              letterSpacing: 0.25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                weather,
                style: const TextStyle(
                  fontSize: 24,
                  // fontWeight: FontWeight.,
                ),
              ),
              const SizedBox(width: 16),
              Image.network(
                link,
                fit: BoxFit.cover,
                height: 32,
              ),
            ],
          ),
          _miscIcons(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      context.pushNamed("aiSuggest", extra: w);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text("Hey CC, got any activities for me?",
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 8),
                        Icon(Icons.chat, color: Theme.of(context).colorScheme.onPrimaryContainer, )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],

      ),
    );
  }

  Row _miscIcons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RoundedIconWLabel(
            color: Colors.yellow[200],
            iconData: Icons.wb_sunny,
            label: "${w.sunrise?.hour}:${w.sunrise?.minute}",
          ),
          RoundedIconWLabel(
            color: Colors.orange[200],
            iconData: Icons.wb_twighlight,
            label: "${w.sunset?.hour}:${w.sunset?.minute}",
          ),
          RoundedIconWLabel(
            color: Colors.grey[200],
            iconData: Icons.wb_cloudy,
            label: "${w.cloudiness?.toStringAsFixed(0)}%",
          ),
          RoundedIconWLabel(
            color: Colors.blue[200],
            iconData: Icons.water_drop,
            label: "${w.humidity?.toStringAsFixed(0)}%",
          ),
          RoundedIconWLabel(
              color: Colors.blueGrey[100],
              label: "${w.windSpeed}",
              iconData: Icons.air,),
        ]);
  }
}
