import 'package:flutter/material.dart';
import 'package:to_do/components.dart';
import 'package:to_do/filter_row.dart';
import 'package:to_do/task_dialog.dart';
import 'package:to_do/themes/theme.dart';

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
        backgroundColor: themeData.colorScheme.secondary,
        child: Icon(Icons.add, color: themeData.colorScheme.onPrimary),
      ),
    );
  }
}
