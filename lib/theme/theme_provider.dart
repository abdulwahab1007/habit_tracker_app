import 'package:flutter/material.dart';
import 'package:practice_habit_tracker/theme/dark_mode.dart';
import 'package:practice_habit_tracker/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  // in this Theme Provider class , I need 
  // instance of the ThemeData
  ThemeData _themeData=lightMode;  
  //getters (for confirming dark Mode as well )
  ThemeData get themedata=>_themeData;

  bool get isDarkMode=>_themeData==darkMode; 
  //setters 
  void setThemeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

  //toggleTheme() method 
  void toggleTheme(){
    if(_themeData==lightMode){
      setThemeData(darkMode);
    }
    else{
      setThemeData(lightMode);
    }
  }
  
}