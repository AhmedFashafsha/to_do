import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/themes/theme.dart';

FloatingActionButton buildFloatingActionButton(ThemeData themeData) {
  return FloatingActionButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    onPressed: () {},
    backgroundColor: themeData.colorScheme.secondary,
    child: Icon(Icons.add, color: themeData.colorScheme.onPrimary),
  );
}

FilterChip buildFilterChip({
  required String label,
  required bool selected,
  required ValueChanged<bool> onSelected,
}) {
  return FilterChip(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    backgroundColor: selected
        ? themeData.colorScheme.primary
        : themeData.colorScheme.secondary,
    selectedColor: themeData.colorScheme.primary,
    label: Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: selected
            ? themeData.colorScheme.onPrimary
            : themeData.colorScheme.onSecondary,
      ),
    ),
    selected: selected,
    onSelected: onSelected,
  );
}

class Task {
  final String title;
  final String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

List<Task> taskList = [
  Task(title: 'Task 1 ', description: 'Description for Task 1'),
  Task(title: 'Task 2', description: 'Description for Task 2'),
  Task(title: 'Task 3', description: 'Description for Task 3'),
];

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> with TickerProviderStateMixin {
  // Separate tasks into active and completed
  List<Task> get activeTasks =>
      taskList.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks =>
      taskList.where((task) => task.isCompleted).toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Active Tasks Section
        ...activeTasks.map((task) => _buildAnimatedTaskItem(task)),

        // Completed Section (only show if there are completed tasks)
        if (completedTasks.isNotEmpty) ...[
          SizedBox(height: 20),
          _buildSectionHeader('Completed'),
          SizedBox(height: 10),
          ...completedTasks.map((task) => _buildAnimatedTaskItem(task)),
        ],
      ],
    );
  }

  Widget _buildAnimatedTaskItem(Task task) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      margin: EdgeInsets.only(bottom: 12),
      transform: Matrix4.identity()
        ..translate(0.0, task.isCompleted ? 10.0 : 0.0, 0.0),
      child: AnimatedOpacity(
        opacity: task.isCompleted ? 0.7 : 1.0,
        duration: Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(task.isCompleted ? 0.96 : 1.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceOut,
            decoration: BoxDecoration(
              color: themeData.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: task.isCompleted
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: _buildTaskItem(task),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: themeData.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              setState(() {
                task.isCompleted = value ?? false;
              });
            },
            shape: CircleBorder(),
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return themeData.colorScheme.secondary;
              }
              return Colors.transparent;
            }),
            checkColor: themeData.colorScheme.onSecondary,
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              task.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: themeData.colorScheme.onPrimary,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: themeData.colorScheme.onPrimary,
                decorationThickness: 2.0,
              ),
            ),
            subtitle: Text(
              task.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: themeData.colorScheme.onPrimary.withValues(alpha: .8),
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: themeData.colorScheme.onPrimary.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
            onTap: () {
              // Handle task tap
            },
          ),
        ),
      ],
    );
  }
}
