import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "../themes/theme_provider.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required final GoRouterState goRouterState,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isDarkMode = false;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Profile",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 75),
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  radius: 50,
                  child: const Text("CM", style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Charlie",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text("Edit Profile", style: TextStyle(fontSize: 16))),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Text("Themes: ", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.brown.shade400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite, color: Colors.red.shade400),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cloudy_snowing, color: Colors.blue.shade800),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.forest, color: Colors.green.shade800),
                    ),
                  ]),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Text("Dark/Light Mode: ", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  IconButton(
                    icon: _isDarkMode
                        ? const Icon(Icons.toggle_on_rounded, size: 40)
                        : const Icon(Icons.toggle_off_rounded, size: 40),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      setState(() {
                        _isDarkMode = !_isDarkMode;
                      });
                    },
                  ),
                ],),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
