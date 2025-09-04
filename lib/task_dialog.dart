import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/components.dart';
import 'package:to_do/theme_manager.dart';

class TaskDialog extends StatefulWidget {
  final Function(Task) onTaskCreated;

  const TaskDialog({super.key, required this.onTaskCreated});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();
  String _selectedCategory = 'No Category';
  bool _showNewCategoryField = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _newCategoryController.dispose();
    super.dispose();
  }

  void _createTask() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a task title'),
          backgroundColor: ThemeManager().themeData.colorScheme.error,
        ),
      );
      return;
    }

    final newTask = Task(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
    );

    widget.onTaskCreated(newTask);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: ThemeManager().themeData.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title Input
              Text(
                'Title',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ThemeManager().themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Buy groceries...',
                  hintStyle: GoogleFonts.inter(
                    color: ThemeManager().themeData.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: ThemeManager().themeData.colorScheme.surface,
                ),
                style: GoogleFonts.inter(
                  color: ThemeManager().themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),

              // Task Description Input
              Text(
                'Description',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ThemeManager().themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Buy milk, eggs, and bread...',
                  hintStyle: GoogleFonts.inter(
                    color: ThemeManager().themeData.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: ThemeManager().themeData.colorScheme.surface,
                ),
                style: GoogleFonts.inter(
                  color: ThemeManager().themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),

              // Category Selection
              Text(
                'Category',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ThemeManager().themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeManager().themeData.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: ThemeManager().themeData.colorScheme.surface,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue == 'Create New Category') {
                          _showNewCategoryField = true;
                        } else {
                          _selectedCategory = newValue!;
                          _showNewCategoryField = false;
                        }
                      });
                    },
                    style: GoogleFonts.inter(
                      color: ThemeManager().themeData.colorScheme.onSurface,
                    ),
                    items: [
                      ...availableCategories.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }),
                      DropdownMenuItem<String>(
                        value: 'Create New Category',
                        child: Text(
                          'Create New Category',
                          style: GoogleFonts.inter(
                            fontStyle: FontStyle.italic,
                            color: ThemeManager().themeData.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // New Category Input Field
              if (_showNewCategoryField) ...[
                SizedBox(height: 16),
                Text(
                  'New Category Name',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ThemeManager().themeData.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _newCategoryController,
                  decoration: InputDecoration(
                    hintText: 'Enter category name',
                    hintStyle: GoogleFonts.inter(
                      color: ThemeManager().themeData.colorScheme.onSurface
                          .withValues(alpha: 0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeManager().themeData.colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeManager().themeData.colorScheme.primary,
                      ),
                    ),
                    filled: true,
                    fillColor: ThemeManager().themeData.colorScheme.surface,
                  ),
                  style: GoogleFonts.inter(
                    color: ThemeManager().themeData.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showNewCategoryField = false;
                          _selectedCategory = 'No Category';
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: ThemeManager().themeData.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_newCategoryController.text.trim().isNotEmpty) {
                          setState(() {
                            addNewCategory(_newCategoryController.text.trim());
                            _selectedCategory = _newCategoryController.text
                                .trim();
                            _showNewCategoryField = false;
                            _newCategoryController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ThemeManager().themeData.colorScheme.primary,
                        foregroundColor:
                            ThemeManager().themeData.colorScheme.onPrimary,
                      ),
                      child: Text(
                        'Add Category',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: _createTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeManager().themeData.colorScheme.primary,
                      foregroundColor:
                          ThemeManager().themeData.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),

                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
