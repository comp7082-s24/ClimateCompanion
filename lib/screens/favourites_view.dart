import "dart:convert";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:go_router/go_router.dart";

class FavoriteActivity {
  final String title;
  final String description;
  final String weatherDescription;

  FavoriteActivity({
    required this.title,
    required this.description,
    required this.weatherDescription,
  });

  factory FavoriteActivity.fromJson(Map<String, dynamic> json) {
    return FavoriteActivity(
      title: json["title"] as String,
      description: json["description"] as String,
      weatherDescription: json["weatherDescription"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "weatherDescription": weatherDescription,
    };
  }
}

class FavoritesManager {
  static const String _favoritesKey = "favorites";

  Future<List<FavoriteActivity>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteActivities = prefs.getStringList(_favoritesKey) ?? [];
    return favoriteActivities.map((e) => FavoriteActivity.fromJson(jsonDecode(e) as Map<String, dynamic>)).toList();
  }
}

class FavouritesView extends StatefulWidget {
  const FavouritesView({
    super.key,
    required this.goRouterState,
  });

  final GoRouterState goRouterState;

  @override
  _FavouritesViewState createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  late Future<List<FavoriteActivity>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoritesFuture = FavoritesManager().getFavorites();
    });
  }

  Map<String, List<FavoriteActivity>> _groupFavoritesByWeather(List<FavoriteActivity> favorites) {
    final Map<String, List<FavoriteActivity>> groupedFavorites = {};
    for (var activity in favorites) {
      if (!groupedFavorites.containsKey(activity.weatherDescription)) {
        groupedFavorites[activity.weatherDescription] = [];
      }
      groupedFavorites[activity.weatherDescription]!.add(activity);
    }
    return groupedFavorites;
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder<List<FavoriteActivity>>(
        future: _favoritesFuture,
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
            final groupedFavorites = _groupFavoritesByWeather(favorites);
            return ListView(
              children: groupedFavorites.entries.map((entry) {
                return ExpansionTile(
                  title: Text(
                    entry.key.toUpperCase(),
                    style: TextStyle(fontSize: 24),
                  ),
                  children: entry.value.map((activity) {
                    return ListTile(
                      title: Text(
                        activity.title,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(activity.description),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
