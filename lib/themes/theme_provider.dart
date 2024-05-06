

import "package:climate_companion/themes/theme.dart";
import "package:flutter/material.dart";

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = defaultLightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == defaultLightMode ? defaultDarkMode : defaultLightMode;
    notifyListeners();
  }

}