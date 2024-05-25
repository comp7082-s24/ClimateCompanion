import "package:climate_companion/components/appbar.dart";
import "package:climate_companion/navigation.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    final Key? key,
  }) : super(key: key ?? const ValueKey<String>("ScaffoldWithNavBar"));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  final List<Destination> routeDestinations = [];

  @override
  void initState() {
    super.initState();
    for (final branch in widget.navigationShell.route.branches) {
      for (final route in branch.routes) {
        if (route is GoRoute) {
          final destination = destinations
              .firstWhereOrNull((final element) => element.name == route.name);
          if (destination != null) {
            routeDestinations.add(destination);
          }
        }
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      // appBar: const MainAppBar(),
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: routeDestinations
            .map(
              (final destination) => BottomNavigationBarItem(
                icon: Icon(destination.icon),
                label: destination.title,
              ),
            )
            .toList(),
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (final int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(final BuildContext context, final int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
