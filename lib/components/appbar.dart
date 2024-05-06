import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "package:climate_companion/themes/theme_provider.dart";

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_2_rounded),
          onPressed: () {
            // GoRouter.of(context).go("/profile");
            context.goNamed("profile");

          },
        ),
      ],
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // This is the standard height for an AppBar
}
