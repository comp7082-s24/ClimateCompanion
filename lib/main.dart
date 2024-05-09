import "package:climate_companion/components/scaffold_with_nav_bar.dart";
import "package:climate_companion/navigation.dart";
import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (final BuildContext context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: WeatherDestination().path,
    routes: <RouteBase>[
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
            navigatorKey: aiSuggestNavigatorKey,
            routes: <RouteBase>[
              AiSuggestDestination(),
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

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      // To use themes make sure you're using the theme from the provider
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: _router,
    );
  }
}
