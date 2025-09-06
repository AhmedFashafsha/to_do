import 'package:flutter/material.dart';

// Default (Purple) Theme
ThemeData defaultTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 154, 136, 232),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 125, 103, 224),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 39, 39, 39),
    onSurface: Colors.white,
    inversePrimary: Color.fromARGB(255, 245, 203, 203),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    foregroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(color: Color(0xff464646)),
  drawerTheme: const DrawerThemeData(scrimColor: Colors.black54),
);

// Blue Theme
ThemeData blueTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 66, 133, 244),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 30, 96, 200),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 39, 39, 39),
    onSurface: Colors.white,
    inversePrimary: Color.fromARGB(255, 203, 229, 245),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    foregroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(color: Color(0xff464646)),
  drawerTheme: const DrawerThemeData(scrimColor: Colors.black54),
);

// Green Theme
ThemeData greenTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 76, 175, 80),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 56, 142, 60),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 39, 39, 39),
    onSurface: Colors.white,
    inversePrimary: Color.fromARGB(255, 220, 245, 203),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    foregroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(color: Color(0xff464646)),
  drawerTheme: const DrawerThemeData(scrimColor: Colors.black54),
);

ThemeData redTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 244, 66, 66),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 200, 30, 30),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 39, 39, 39),
    onSurface: Colors.white,
    inversePrimary: Color.fromARGB(255, 203, 229, 245),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    foregroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(color: Color(0xff464646)),
  drawerTheme: const DrawerThemeData(scrimColor: Colors.black54),
);

// Theme map for easy access
Map<String, ThemeData> appThemes = {
  'Default': defaultTheme,
  'Blue': blueTheme,
  'Green': greenTheme,
  'Red': redTheme,
};

// Current theme data - defaults to purple theme
ThemeData themeData = defaultTheme;
