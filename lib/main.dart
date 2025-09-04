import 'package:flutter/material.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/components.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/filter_row.dart';
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
        backgroundColor: themeData.scaffoldBackgroundColor,
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FilterRow(),
              Expanded(child: TaskList()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [buildFloatingActionButton(themeData)],
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
