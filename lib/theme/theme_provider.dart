

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker18/theme/dark_mode.dart';

import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  //initially light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData=> _themeData;

  //is current theme dartk mode
  bool get isDarkMode=>_themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  //toggle theme
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
}