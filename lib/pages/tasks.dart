import 'package:flutter/material.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/components.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/filter_row.dart';
import 'package:to_do/task_dialog.dart';
import 'package:to_do/theme_manager.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
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
      appBar: buildAppBar(context: context, title: 'Tasks'),
      drawer: buildDrawer(context),
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
        backgroundColor: ThemeManager().themeData.colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: ThemeManager().themeData.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
