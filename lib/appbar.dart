import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/theme_manager.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: ThemeManager().themeData.appBarTheme.backgroundColor,
    centerTitle: true,

    title: SafeArea(
      child: Text(
        title,
        style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu,
          color: ThemeManager().themeData.colorScheme.onSurface,
          size: 40,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
  );
}
