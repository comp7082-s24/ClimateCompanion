import "package:climate_companion/components/scaffold_with_nav_bar.dart";
import "package:climate_companion/navigation.dart";
import "package:climate_companion/state/app_state_provider.dart";
import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Gemini.init(apiKey: "AIzaSyC6Ml5kzEFC736NQBs_ctUxbWyVkeoPwO4");

  final prefs = await SharedPreferences.getInstance();
  final appState = AppStateProvider(prefs);

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: appState.isProfileComplete ? WeatherDestination().path : CreateProfileDestination().path,
    routes: <RouteBase>[
      CreateProfileDestination(),
      UpdateProfileDestination(),
      AiSuggestDestination(),
      StatefulShellRoute.indexedStack(
        builder: (
          final BuildContext context,
          final GoRouterState state,
          final StatefulNavigationShell navigationShell,
        ) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: weatherNavigatorKey,
            routes: <RouteBase>[
              WeatherDestination(),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: favoritesNavigatorKey,
            routes: <RouteBase>[
              FavoritesDestination(),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: <RouteBase>[
              ProfileDestination(),
            ],
          ),
        ],
      ),
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(
          create: (final BuildContext context) => appState,
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (final BuildContext context) => ThemeProvider(),
        ),
      ],
      child: MainApp(router: router),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      // To use themes make sure you're using the theme from the provider
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: router,
    );
  }
}
