import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class FavoriteActivity {
  final String title;
  final String description;
  final String weatherDescription;

  FavoriteActivity({required this.title, required this.description, required this.weatherDescription});

  factory FavoriteActivity.fromJson(Map<String, dynamic> json) {
    return FavoriteActivity(
      title: json['title'],
      description: json['description'],
      weatherDescription: json['weatherDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'weatherDescription': weatherDescription,
    };
  }
}

class FavoritesManager {
  static const String _favoritesKey = 'favorites';

  Future<List<FavoriteActivity>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteActivities = prefs.getStringList(_favoritesKey) ?? [];
    return favoriteActivities.map((e) => FavoriteActivity.fromJson(jsonDecode(e))).toList();
  }
}

class FavouritesView extends StatelessWidget {
  const FavouritesView({
    super.key,
    required this.goRouterState,
  });

  final GoRouterState goRouterState;

  Future<List<FavoriteActivity>> _loadFavorites() async {
    return FavoritesManager().getFavorites();
  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<FavoriteActivity>>(
      future: _loadFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No favorites yet."),
          );
        } else {
          final favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final activity = favorites[index];
              return ListTile(
                title: Text(activity.title),
                subtitle: Text(activity.description),
                trailing: Text(activity.weatherDescription),
              );
            },
          );
        }
      },
    );
  }
}
