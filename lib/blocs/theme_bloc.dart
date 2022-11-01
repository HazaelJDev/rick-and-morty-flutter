
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class ThemeBloc with ChangeNotifier{
  ThemeData _themeData = darkTheme;
  bool _isDark = true;

  ThemeBloc(ThemeData themeData, {bool isDark = true}){
    _isDark = isDark;
    _themeData = themeData;
  }

  bool getIsDark() => _isDark;

  ThemeData getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    _isDark = !_isDark;
    notifyListeners();
  }
}