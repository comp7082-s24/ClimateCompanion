import "package:climate_companion/themes/theme.dart";
import "package:flutter/material.dart";

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = defaultLightMode;

  ThemeData get themeData => _themeData;

  set themeData(final ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // @param string
  void toggleTheme() {
    // Switch Statement

    _themeData =
        _themeData == defaultLightMode ? defaultDarkMode : defaultLightMode;
    notifyListeners();
  }
}
