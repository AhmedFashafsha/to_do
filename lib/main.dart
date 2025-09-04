import 'package:flutter/material.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/components.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/filter_row.dart';
import 'package:to_do/pages/tasks.dart';
import 'package:to_do/task_dialog.dart';
import 'package:to_do/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
     
      body: const Tasks(),
    );
  }
}
