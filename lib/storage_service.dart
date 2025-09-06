import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/components.dart';

class StorageService {
  static const String _tasksKey = 'tasks';
  static const String _themeKey = 'selected_theme';
  static const String _categoriesKey = 'categories';

  // Save tasks to local storage
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => {
      'title': task.title,
      'description': task.description,
      'category': task.category,
      'isCompleted': task.isCompleted,
    }).toList();
    await prefs.setString(_tasksKey, jsonEncode(tasksJson));
  }

  // Load tasks from local storage
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);
    
    if (tasksString == null) {
      // Return default tasks if no saved tasks exist
      return [
        Task(
          title: 'Complete project presentation',
          description: 'Prepare slides and practice presentation for Monday meeting',
          category: 'Work',
        ),
        Task(
          title: 'Buy groceries',
          description: 'Milk, bread, eggs, and vegetables for the week',
          category: 'Shopping',
        ),
        Task(
          title: 'Study for exam',
          description: 'Review chapters 5-8 for tomorrow\'s mathematics exam',
          category: 'School',
        ),
      ];
    }

    final List<dynamic> tasksJson = jsonDecode(tasksString);
    return tasksJson.map((taskJson) => Task(
      title: taskJson['title'],
      description: taskJson['description'],
      category: taskJson['category'] ?? 'No Category',
      isCompleted: taskJson['isCompleted'] ?? false,
    )).toList();
  }

  // Save selected theme
  static Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  // Load selected theme
  static Future<String> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'Default';
  }

  // Save categories
  static Future<void> saveCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_categoriesKey, categories);
  }

  // Load categories
  static Future<List<String>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCategories = prefs.getStringList(_categoriesKey);
    
    if (savedCategories == null) {
      // Return default categories if no saved categories exist
      return [
        'No Category',
        'Work',
        'Home',
        'School',
        'Personal',
        'Shopping',
      ];
    }
    
    return savedCategories;
  }
}
