import 'package:flutter/material.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/components.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/filter_row.dart';
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
  Set<String> selectedFilters = {'All'};

  void _addNewTask(Task newTask) {
    setState(() {
      taskList.add(newTask);
    });
  }

  void _onFilterChanged(Set<String> filters) {
    setState(() {
      selectedFilters = filters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TaskDialog(onTaskCreated: _addNewTask);
            },
          );
        },
        backgroundColor: themeData.colorScheme.secondary,
        child: Icon(Icons.add, color: themeData.colorScheme.onPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FilterRow(onFilterChanged: _onFilterChanged),
            Expanded(
              child: TaskList(
                onAddTask: _addNewTask,
                selectedFilters: selectedFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
