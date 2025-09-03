import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFAC88E8),
    onPrimary: Colors.white,
    secondary: Color(0xff9667E0),
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
