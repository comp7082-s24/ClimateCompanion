import "package:flutter/material.dart";

ThemeData defaultLightMode = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey, // Neutral blue as the primary swatch
  primaryColor: Colors.white, // Main color is white
  primaryColorLight: Colors.grey[300], // Light grey for elevated elements
  primaryColorDark: Colors.grey[900], // Dark grey for contrasting elements
  hintColor: Colors.blue[600], // More vibrant blue for accent elements
  scaffoldBackgroundColor: Colors.white, // Background is white
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, // AppBar is white
    foregroundColor: Colors.black, // Text and icons in AppBar are black
  ),
  cardColor: Colors.grey[50], // Cards are very light grey, near white
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
        color: Colors.black,), // Main text color is black for readability
    bodyMedium: TextStyle(
        color: Colors.grey[600],), // Secondary text color is a darker grey
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[800], // Icon color is dark grey for better visibility
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[300], // Button color is a soft blue
    textTheme:
        ButtonTextTheme.primary, // Use the primary text theme for buttons
  ),
);

ThemeData defaultDarkMode = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey, //
  primaryColor: Colors.black, // Main color is black
  primaryColorLight: Colors.grey[800], // Lighter shade of grey instead of blue
  primaryColorDark: Colors.black, // Dark color is black
  hintColor: Colors.blue[200], // For elements like buttons and toggles
  scaffoldBackgroundColor: Colors.black, // Background is black
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // AppBar is also black
    foregroundColor: Colors.white, // Text and icons in AppBar are white
  ),
  cardColor: Colors.grey[850], // Cards are a slightly lighter shade of black
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Main text color
    bodyMedium:
        TextStyle(color: Colors.white70), // Secondary text color (slightly
    // opaque)
  ),
  iconTheme: const IconThemeData(
    color: Colors.white70, //
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[300], // Button color
    textTheme:
        ButtonTextTheme.primary, // Use the primary text theme for buttons
  ),
);
