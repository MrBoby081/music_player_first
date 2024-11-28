import 'package:flutter/material.dart';
import 'package:music_player/themes/dark_mode.dart';
import 'package:music_player/themes/ligh_mode.dart';



class ThemeProvider extends ChangeNotifier {
//initially, light mode
  ThemeData _themeData = lightMode;

//get theme
  ThemeData get themeData => _themeData;

// is dark mode
  bool get isDarkMode => _themeData == darkMode;

//set theme
  set themedata(ThemeData themedata) {
    _themeData = themedata;

    //update ui
    notifyListeners();
  }

// toggle theme
  void togglTheme() {
    if (_themeData == lightMode) {
      themedata = darkMode;
    } else {
      themedata = lightMode;
    }
  }
}
