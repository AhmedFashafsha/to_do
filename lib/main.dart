import 'package:flutter/material.dart';
import 'package:to_do/pages/tasks.dart';
import 'package:to_do/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeManager(),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeManager().themeData,
          home: const Tasks(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
