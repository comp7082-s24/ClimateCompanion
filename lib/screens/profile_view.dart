import "package:climate_companion/components/delete.profile.button.dart";
import "package:climate_companion/navigation.dart";
import "package:climate_companion/state/app_state_provider.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:climate_companion/themes/theme_provider.dart";

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
    final name = Provider.of<AppStateProvider>(context).name ?? "";

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildAvatarAndName(name),
            const SizedBox(height: 16),
            _buildUpdateProfile(context),
            const SizedBox(height: 16),
            _buildThemes(context),
            _buildDarkLightMode(context),
            _buildDeleteProfile(context),
          ],
        ),
      ),
    );
  }

  SizedBox _buildDeleteProfile(final BuildContext context) {
    return SizedBox(
            width: double.infinity,
            child: DeleteProfileButton(
              onPressed: () {
                Provider.of<AppStateProvider>(context, listen: false).resetProfile();
                context.replaceNamed(CreateProfileDestination().name!);
              },
            ),
          );
  }

  Row _buildDarkLightMode(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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
      ],
    );
  }

  Row _buildThemes(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text("Themes: ", style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).switchToBrownTheme();
              },
              icon: Icon(
                Icons.bookmark,
                color: Colors.brown.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).switchToRedTheme();
              },
              icon: Icon(Icons.favorite, color: const Color.fromARGB(255, 231, 180, 179)),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).switchToBlueTheme();
              },
              icon: Icon(Icons.cloudy_snowing, color: Colors.blue.shade800),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).switchToGreenTheme();
              },
              icon: Icon(Icons.forest, color: Colors.green.shade800),
            ),
          ],
        ),
      ],
    );
  }

  ElevatedButton _buildUpdateProfile(final BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.pushNamed(UpdateProfileDestination().name!);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: Text("Update Profile", style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  Column _buildAvatarAndName(final String name) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown.shade800,
          radius: 50,
          child: Text(name.characters.firstOrNull ?? "?",
              style: const TextStyle(fontSize: 24, color: Colors.white)),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
