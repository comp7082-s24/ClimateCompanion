import "package:climate_companion/views/home.dart";
import "package:climate_companion/views/profile.dart";
import "package:climate_companion/views/suggestions.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:climate_companion/bottom_nav_scaffold.dart";
import "package:climate_companion/views/favourites.dart";

/// This is how navigation and routes are set up.
/// The [RoutePath] enum is used to define the paths for the application.
/// The [AppNavigation] class is used to define the initial route and the navigators for the application.

enum RoutePath {
  home(path: "/home"),
  profile(path: "/profile"),
  suggestions(path: "suggestions"),
  favourites(path: "/favourites");

  final String path;

  const RoutePath({required this.path});
}

class AppNavigation {
  AppNavigation._();

  static String initialRoute = RoutePath.home.path;

  // Navigators for the application
  static final _navigator = GlobalKey<NavigatorState>();
  static final _homeNavigator = GlobalKey<NavigatorState>(debugLabel: "HomeNavigator");

  // Go Router Config
  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    navigatorKey: _navigator,
    routes: [
      GoRoute(
        path: RoutePath.profile.path,
        name: RoutePath.profile.name,
        builder: (final context, final state) => const Profile(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (final BuildContext context, final GoRouterState state, final navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          /// For the First Navigation Tab Called Home
          StatefulShellBranch(
            navigatorKey: _homeNavigator,
            routes: [
              GoRoute(
                path: RoutePath.home.path,
                name: RoutePath.home.name,
                builder: (final BuildContext context, final GoRouterState state) => Home(
                  key: state.pageKey,
                ),
                routes: [
                  GoRoute(
                    path: RoutePath.suggestions.path,
                    name: RoutePath.suggestions.name,
                    builder: (final BuildContext context, final GoRouterState state) => Suggestions(
                      key: state.pageKey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// For the Second Navigation Tab Called Favourites
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.favourites.path,
                name: RoutePath.favourites.name,
                builder: (final BuildContext context, final GoRouterState state) => const Favourites(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
