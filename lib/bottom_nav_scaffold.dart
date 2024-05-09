import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// This is how navigation and routes are set up. This page is the template for the Bottom Nav Bar
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goBranch(final int index) {
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      // This is where the navigation shell is placed
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        indicatorColor: Colors.blue[300],
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.cloud_outlined),
            label: "Weather",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
