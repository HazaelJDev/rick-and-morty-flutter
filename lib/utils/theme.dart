import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF375F87),
  secondary: Color(0xFF6BA660),
  surface: Color(0xFFF9F9F9),
  background: Color(0xFFF9F9F9),
  error: Color(0xFFFF477B),
  shadow: Color(0xFF141927),
  onPrimary: Color(0xFFF9F9F9),
  onSecondary: Color(0xFF141927),
  onSurface: Color(0xFF141927),
  onBackground: Color(0xFF141927),
  onError: Color(0xFF141927),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFADD7E9),
  secondary: Color(0xFFCBE7BF),
  surface: Color(0xFF262B38),
  background: Color(0xFF141927),
  error: Color(0xFFFF909A),
  shadow: Color(0xFF141927),
  onPrimary: Color(0xFF141927),
  onSecondary: Color(0xFF141927),
  onSurface: Color(0xFFF9F9F9),
  onBackground: Color(0xFFF9F9F9),
  onError: Color(0xFF141927),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.background,
    centerTitle: true,
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
  ),
  
  scaffoldBackgroundColor: lightColorScheme.background,
  
  cardTheme: CardTheme(
    color: lightColorScheme.surface,
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: lightColorScheme.surface,
    iconColor: lightColorScheme.primary,
    filled: true,
    
  ),
  
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.background,
    centerTitle: true,
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
  ),
  scaffoldBackgroundColor: darkColorScheme.background,
  cardTheme: CardTheme(
    color: darkColorScheme.surface,
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: darkColorScheme.surface,
    iconColor: darkColorScheme.primary,
    filled: true,
  ),
  
);
