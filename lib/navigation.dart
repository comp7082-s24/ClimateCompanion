import "package:climate_companion/screens/ai_suggest_view.dart";
import "package:climate_companion/screens/create_profile_view.dart";
import "package:climate_companion/screens/favourites_view.dart";
import "package:climate_companion/screens/profile_view.dart";
import "package:climate_companion/screens/update_profile_view.dart";
import "package:climate_companion/screens/weather_view.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> weatherNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "weatherNavKey");
final GlobalKey<NavigatorState> favoritesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "favoritesNavKey");
final GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "profileNavKey");

final List<Destination> destinations = <Destination>[
  WeatherDestination(),
  FavoritesDestination(),
  ProfileDestination(),
];

sealed class Destination extends GoRoute {
  Destination({
    required super.path,
    required this.title,
    required this.icon,
    required super.name,
    required super.builder,
  });

  /// Title to be displayed in the UI
  final String title;

  /// IconData to be displayed in the Icon
  final IconData icon;
}

final class WeatherDestination extends Destination {
  WeatherDestination()
      : super(
          name: "weather",
          path: "/weather",
          title: "Weather",
          icon: Icons.cloud,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              WeatherView(goRouterState: state),
        );
}

final class AiSuggestDestination extends Destination {
  AiSuggestDestination()
      : super(
          name: "aiSuggest",
          path: "/ai-suggest",
          title: "AI Suggest",
          icon: Icons.lightbulb,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              AiSuggestView(goRouterState: state),
        );
}

final class FavoritesDestination extends Destination {
  FavoritesDestination()
      : super(
          name: "favorites",
          path: "/favorites",
          title: "Favorites",
          icon: Icons.favorite,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              FavouritesView(goRouterState: state),
        );
}

final class ProfileDestination extends Destination {
  ProfileDestination()
      : super(
          name: "profile",
          path: "/profile",
          title: "Profile",
          icon: Icons.person,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              ProfileView(goRouterState: state),
        );
}

final class CreateProfileDestination extends Destination {
  CreateProfileDestination()
      : super(
          name: "create_profile",
          path: "/createProfile",
          title: "Create Profile",
          icon: Icons.account_circle,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              const CreateProfileView(),
        );
}

final class UpdateProfileDestination extends Destination {
  UpdateProfileDestination()
      : super(
          name: "update_profile",
          path: "/updateProfile",
          title: "Update Profile",
          icon: Icons.account_circle,
          builder: (
            final BuildContext context,
            final GoRouterState state,
          ) =>
              const UpdateProfileView(),
        );
}
