import "package:flutter/material.dart";

final List<Color> colours = [
  const Color(0xFF2196F3),
  const Color(0xFFFFC107),
  const Color(0xFF4CAF50),
  const Color(0xFFFF9800),
  const Color(0xFF9C27B0),
  const Color(0xFFE91E63),
  const Color(0xFF00BCD4),
  const Color(0xFF8BC34A),
  const Color(0xFF3F51B5),
  const Color(0xFF795548),
  const Color(0xFFFF5722),
  const Color(0xFF673AB7),
  const Color(0xFF009688),
  const Color(0xFFCDDC39),
  const Color(0xFF607D8B),
  const Color(0xFF9E9E9E),
];

ThemeData defaultLightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primarySwatch: Colors.blueGrey,
  // Neutral blue as the primary swatch
  primaryColor: Colors.white,
  // Main color is white
  primaryColorLight: Colors.grey[300],
  // Light grey for elevated elements
  primaryColorDark: Colors.grey[900],
  // Dark grey for contrasting elements
  hintColor: Colors.blue[600],
  // More vibrant blue for accent elements
  scaffoldBackgroundColor: Colors.white,
  // Background is white
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, // AppBar is white
    foregroundColor: Colors.black, // Text and icons in AppBar are black
  ),
  cardColor: Colors.grey[50],
  // Cards are very light grey, near white
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
      color: Colors.black,
    ), // Main text color is black for readability
    bodyMedium: TextStyle(
      color: Colors.grey[600],
    ), // Secondary text color is a darker grey
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[800], // Icon color is dark grey for better visibility
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[300], // Button color is a soft blue
    textTheme: ButtonTextTheme.primary, // Use the primary text theme for buttons
  ),
  fontFamily: "Roboto",
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue[300],
    unselectedItemColor: Colors.grey[800],
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData defaultDarkMode = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.grey[900],
  // Main color is black
  primaryColorLight: Colors.grey[800],
  // Lighter shade of grey instead of blue
  primaryColorDark: Colors.black,
  // Dark color is black
  hintColor: Colors.blue[200],
  // For elements like buttons and toggles
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white, // Text and icons in AppBar are white
  ),
  cardColor: Colors.grey[850],
  // Cards are a slightly lighter shade of black
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Main text color
    bodyMedium: TextStyle(color: Colors.white70), // Secondary text color (slightly
    // opaque)
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[300], // Button color
    textTheme: ButtonTextTheme.primary, // Use the primary text theme for buttons
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF27292E),
    selectedItemColor: Colors.blue[300],
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

// TODO FRomSEED
ThemeData defaultDarkModde = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
  // brightness: Brightness.dark,
);
