import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:climate_companion/themes/theme_provider.dart";

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  bool _isDarkMode = false;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
}
