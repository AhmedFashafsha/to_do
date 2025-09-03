import 'package:flutter/material.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        backgroundColor: themeData
            .scaffoldBackgroundColor, 
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),
       
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: themeData.colorScheme.surface,
          child: Center(
            child: Text(
              'Welcome to your To-Do App!',
              style: TextStyle(
                fontSize: 24,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
