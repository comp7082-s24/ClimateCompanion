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


ThemeData brownTheme = ThemeData(
  primarySwatch: Colors.brown,
  primaryColor: const Color.fromARGB(255, 180, 143, 137),
  primaryColorLight: Colors.brown[800],
  primaryColorDark: Color.fromARGB(255, 134, 103, 103),
  hintColor: Colors.brown[200],
  scaffoldBackgroundColor: Color.fromARGB(255, 68, 48, 48),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 139, 102, 102),
    foregroundColor: Color.fromARGB(255, 160, 139, 139),
  ),
  cardColor: Color.fromARGB(255, 139, 102, 102),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 32.0,
      color: Color.fromARGB(255, 233, 230, 230),
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 241, 239, 239),
    ),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(179, 133, 103, 103)),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.brown[300],
    textTheme: ButtonTextTheme.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 139, 102, 102),
    selectedItemColor: Colors.brown[300],
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData redTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: const Color.fromARGB(255, 180, 0, 0), // Adjusted shade of red
  primaryColorLight: Colors.red[800], // Adjusted shade of red
  primaryColorDark: Color.fromARGB(255, 134, 0, 0), // Adjusted shade of red
  hintColor: Colors.red[200], // Adjusted shade of red
  scaffoldBackgroundColor: Color.fromARGB(255, 163, 21, 21), // Adjusted shade of red
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 231, 85, 85), // Adjusted shade of red
    foregroundColor: Color.fromARGB(255, 160, 0, 0), // Adjusted shade of red
  ),
  cardColor: Color.fromARGB(255, 124, 10, 10), // Adjusted shade of red
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 32.0,
      color: Color.fromARGB(255, 211, 204, 204), // Adjusted shade of red
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 233, 227, 227), // Adjusted shade of red
    ),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(179, 133, 0, 0)), // Adjusted shade of red
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.red[300], // Adjusted shade of red
    textTheme: ButtonTextTheme.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 231, 85, 85), // Adjusted shade of red
    selectedItemColor: Colors.red[300], // Adjusted shade of red
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData blueTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: const Color.fromARGB(255, 0, 0, 180), // Adjusted shade of blue
  primaryColorLight: Colors.blue[800], // Adjusted shade of blue
  primaryColorDark: Color.fromARGB(255, 0, 0, 134), // Adjusted shade of blue
  hintColor: Colors.blue[200], // Adjusted shade of blue
  scaffoldBackgroundColor: Color.fromARGB(255, 118, 118, 222), // Adjusted shade of blue
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 85, 85, 231), // Adjusted shade of blue
    foregroundColor: Color.fromARGB(255, 0, 0, 160), // Adjusted shade of blue
  ),
  cardColor: Color.fromARGB(255, 10, 10, 124), // Adjusted shade of blue
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 32.0,
      color: Color.fromARGB(255, 204, 211, 211), // Adjusted shade of blue
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 227, 233, 233), // Adjusted shade of blue
    ),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(179, 0, 0, 133)), // Adjusted shade of blue
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[300], // Adjusted shade of blue
    textTheme: ButtonTextTheme.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 85, 85, 231), // Adjusted shade of blue
    selectedItemColor: Colors.blue[300], // Adjusted shade of blue
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData greenTheme = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: const Color.fromARGB(255, 0, 180, 0), // Adjusted shade of green
  primaryColorLight: Colors.green[800], // Adjusted shade of green
  primaryColorDark: Color.fromARGB(255, 35, 108, 35), // Adjusted shade of green
  hintColor: Colors.green[200], // Adjusted shade of green
  scaffoldBackgroundColor: Color.fromARGB(255, 143, 205, 143), // Adjusted shade of green
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 85, 231, 85), // Adjusted shade of green
    foregroundColor: Color.fromARGB(255, 0, 160, 0), // Adjusted shade of green
  ),
  cardColor: Color.fromARGB(255, 10, 124, 10), // Adjusted shade of green
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 32.0,
      color: Color.fromARGB(255, 204, 211, 204), // Adjusted shade of green
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 227, 233, 227), // Adjusted shade of green
    ),
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(179, 0, 133, 0)), // Adjusted shade of green
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.green[300], // Adjusted shade of green
    textTheme: ButtonTextTheme.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 85, 231, 85), // Adjusted shade of green
    selectedItemColor: Colors.green[300], // Adjusted shade of green
    unselectedItemColor: Colors.white70,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);
