import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/themes/theme.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,

    title: SafeArea(
      child: Text(
        'TASKS',
        style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    ),

    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu,
          color: themeData.colorScheme.onSurface,
          size: 40,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
  );
}
