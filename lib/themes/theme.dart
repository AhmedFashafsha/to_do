import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
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
    backgroundColor: Color(0xff1E1E1E),
    foregroundColor: Colors.white,
  ),
  dividerTheme: DividerThemeData(color: Color(0xff464646)),
  drawerTheme: const DrawerThemeData(scrimColor: Colors.black54),
);
