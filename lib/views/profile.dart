import "package:climate_companion/navigation/app_navigation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(RoutePath.home.name);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const Center(
        child: Text("Profile"),
      ),
    );
  }
}
