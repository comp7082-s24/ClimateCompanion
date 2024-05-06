import "package:climate_companion/components/appbar.dart";
import "package:climate_companion/navigation/app_navigation.dart";
import "package:climate_companion/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (final BuildContext context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      title: "Climate Companion",
      theme: Provider.of<ThemeProvider>(context).themeData,
      routerConfig: AppNavigation.router,


      // To use themes make sure you're using the theme from the provider
      // theme: Provider.of<ThemeProvider>(context).themeData,
      // home: Scaffold(
      //   appBar: const MainAppBar(),
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         ElevatedButton(
      //           onPressed: () {
      //             Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      //           },
      //           child: const Text("Toggle Theme"),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text("This is a sample text."),
      //       ],
      //     )
      //     ),
      //   ),

    );
  }
}
