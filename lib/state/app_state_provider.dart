import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class AppStateProvider extends ChangeNotifier {
  String? _name;
  DateTime? _dob;
  Color? _favouriteColour;
  bool? _isProfileComplete;

  SharedPreferences prefs;

  AppStateProvider(this.prefs) {
    _name = prefs.getString("name");
    _dob = prefs.getInt("dob") != null ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt("dob")!) : null;
    _favouriteColour = prefs.getInt("favouriteColour") != null ? Color(prefs.getInt("favouriteColour")!) : null;
    _isProfileComplete = prefs.getBool("isProfileComplete");
  }

  String? get name => _name;

  DateTime? get dob => _dob;

  Color? get favouriteColour => _favouriteColour;

  bool get isProfileComplete => _isProfileComplete ?? false;

  void setName(final String name) {
    _name = name;
    prefs.setString("name", name);
    notifyListeners();
  }

  void setDob(final DateTime dob) {
    _dob = dob;
    prefs.setInt("dob", dob.millisecondsSinceEpoch);
    notifyListeners();
  }

  void setFavouriteColour(final Color colour) {
    _favouriteColour = colour;
    prefs.setInt("favouriteColour", colour.value);
    notifyListeners();
  }

  void setIsProfileComplete(final bool isProfileComplete) {
    _isProfileComplete = isProfileComplete;
    prefs.setBool("isProfileComplete", isProfileComplete);
    notifyListeners();
  }

  void resetProfile() {
    prefs.clear();
    _name = null;
    _dob = null;
    _favouriteColour = null;
    _isProfileComplete = null;
    notifyListeners();
  }
}
