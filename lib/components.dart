import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/task_dialog.dart';
import 'package:to_do/theme_manager.dart';
import 'package:to_do/task_manager.dart';

// Global categories access through TaskManager
List<String> get availableCategories => TaskManager().categories;

void addNewCategory(String category) {
  TaskManager().addCategory(category);
}

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return TaskDialog(
            onTaskCreated: (Task newTask) {
              // This will be handled in the parent widget
            },
          );
        },
      );
    },
    backgroundColor: ThemeManager().themeData.colorScheme.secondary,
    child: Icon(
      Icons.add,
      color: ThemeManager().themeData.colorScheme.onPrimary,
    ),
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
        ? ThemeManager().themeData.colorScheme.primary
        : ThemeManager().themeData.colorScheme.secondary,
    selectedColor: ThemeManager().themeData.colorScheme.primary,
    label: Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: selected
            ? ThemeManager().themeData.colorScheme.onPrimary
            : ThemeManager().themeData.colorScheme.onSecondary,
      ),
    ),
    selected: selected,
    onSelected: onSelected,
  );
}

class Task {
  final String title;
  final String description;
  final String category;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.category = 'No Category',
    this.isCompleted = false,
  });
}

// Global taskList getter that uses TaskManager for backward compatibility
List<Task> get taskList => TaskManager().taskList;

class TaskList extends StatefulWidget {
  final Function(Task) onAddTask;
  final Set<String> selectedFilters;

  const TaskList({
    super.key,
    required this.onAddTask,
    required this.selectedFilters,
  });

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> with TickerProviderStateMixin {
  // Filter tasks based on selected filters and completion status
  List<Task> get activeTasks {
    final filtered = widget.selectedFilters.contains('All')
        ? taskList.where((task) => !task.isCompleted).toList()
        : taskList
              .where(
                (task) =>
                    !task.isCompleted &&
                    widget.selectedFilters.contains(task.category),
              )
              .toList();
    return filtered;
  }

  List<Task> get completedTasks {
    final filtered = widget.selectedFilters.contains('All')
        ? taskList.where((task) => task.isCompleted).toList()
        : taskList
              .where(
                (task) =>
                    task.isCompleted &&
                    widget.selectedFilters.contains(task.category),
              )
              .toList();
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TaskManager(),
      builder: (context, child) {
        // Show loading indicator if TaskManager is not initialized
        if (!TaskManager().isInitialized) {
          return Center(child: CircularProgressIndicator());
        }

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
      },
    );
  }

  Widget _buildAnimatedTaskItem(Task task) {
    return Dismissible(
      key: ValueKey(task.title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        final removedTask = task;
        TaskManager().removeTask(task);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Task deleted',
              style: GoogleFonts.inter(
                color: ThemeManager().themeData.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: ThemeManager()
                .themeData
                .colorScheme
                .primaryContainer, // Darker tone for SnackBar
            action: SnackBarAction(
              label: 'Undo',
              textColor: ThemeManager().themeData.colorScheme.onPrimary,
              onPressed: () {
                TaskManager().addTask(removedTask);
              },
            ),
          ),
        );
      },
      background: Container(
        color: ThemeManager().themeData.colorScheme.error.withValues(
          alpha: 0.9,
        ), // Darker delete background
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: ThemeManager().themeData.colorScheme.onError.withValues(
            alpha: 0.9,
          ), // Darker delete icon
        ),
      ),
      child: AnimatedContainer(
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
                color: ThemeManager().themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: task.isCompleted
                    ? [
                        BoxShadow(
                          color: ThemeManager().themeData.colorScheme.shadow
                              .withValues(alpha: 0.3),
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
            color: ThemeManager().themeData.colorScheme.onSurface.withValues(
              alpha: 0.7,
            ),
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
              TaskManager().toggleTaskCompletion(task);
            },
            shape: CircleBorder(),
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return ThemeManager().themeData.colorScheme.secondary;
              }
              return Colors.transparent;
            }),
            checkColor: ThemeManager().themeData.colorScheme.onSecondary,
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              task.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ThemeManager().themeData.colorScheme.onPrimary,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: ThemeManager().themeData.colorScheme.onPrimary,
                decorationThickness: 2.0,
              ),
            ),
            subtitle: Text(
              task.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeManager().themeData.colorScheme.onPrimary
                    .withValues(alpha: .8),
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: ThemeManager().themeData.colorScheme.onPrimary
                    .withValues(alpha: 0.8),
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
