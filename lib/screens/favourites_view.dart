import "dart:async";
import "dart:convert";
import "package:climate_companion/components/page_header.dart";
import "package:climate_companion/components/rounded_container.dart";
import "package:climate_companion/constants.dart";
import "package:climate_companion/navigation.dart";
import "package:climate_companion/screens/ai_suggest_view.dart";
import "package:flutter/material.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:go_router/go_router.dart";
import "package:climate_companion/models/favourite_activity.dart";

class FavoritesManager {
  static const String _favoritesKey = "favorites";

  Future<List<FavoriteActivity>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteActivities = prefs.getStringList(_favoritesKey) ?? [];
    return favoriteActivities.map((final e) => FavoriteActivity.fromJson(jsonDecode(e) as Map<String, dynamic>)).toList();
  }
}

class FavouritesView extends StatefulWidget {
  const FavouritesView({
    super.key,
    required this.goRouterState,
  });

  final GoRouterState goRouterState;

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  late Future<List<FavoriteActivity>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    dateUpdateRequested.addListener(_loadFavorites);
  }

  @override
  void dispose() {
    dateUpdateRequested.removeListener(_loadFavorites);
    super.dispose();
  }

  void _loadFavorites() {
    setState(() {
      _favoritesFuture = FavoritesManager().getFavorites();
    });
  }

  Map<String, List<FavoriteActivity>> _groupFavoritesByWeather(
    final List<FavoriteActivity> favorites,
  ) {
    final Map<String, List<FavoriteActivity>> groupedFavorites = {};
    for (final activity in favorites) {
      if (!groupedFavorites.containsKey(activity.weatherDescription)) {
        groupedFavorites[activity.weatherDescription] = [];
      }
      groupedFavorites[activity.weatherDescription]!.add(activity);
    }
    return groupedFavorites;
  }

  @override
  Widget build(final BuildContext context) {
    final cardColor = Theme.of(context).cardColor.withOpacity(0.9);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(title: FavoritesDestination().title),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<FavoriteActivity>>(
                future: _favoritesFuture,
                builder: (final context, final snapshot) {
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
                      child: Text(Constants.noFavouritesMessage),
                    );
                  } else {
                    final favorites = snapshot.data!;
                    final groupedFavorites = _groupFavoritesByWeather(favorites);
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: groupedFavorites.length,
                      itemBuilder: (final context, final index) {
                        final entry = groupedFavorites.entries.toList()[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: FadeInAnimation(
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  entry.key.toUpperCase(),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                children: entry.value.map((final activity) {
                                  return _buildFavCard(activity, context, cardColor);
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildFavCard(FavoriteActivity activity, BuildContext context, Color cardColor) {
    return Column(
                                  children: [
                                    roundedContainer(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              activity.title,
                                            ),
                                            Text(
                                              activity.description,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      color: cardColor,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                );
  }
}
