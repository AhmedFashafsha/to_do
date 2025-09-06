import 'package:flutter/material.dart';
import 'package:to_do/components.dart';
import 'package:to_do/storage_service.dart';

class TaskManager extends ChangeNotifier {
  static final TaskManager _instance = TaskManager._internal();
  factory TaskManager() => _instance;
  TaskManager._internal();

  List<Task> _tasks = [];
  List<String> _categories = [];
  bool _isInitialized = false;

  List<Task> get tasks => _tasks;
  List<String> get categories => _categories;
  bool get isInitialized => _isInitialized;

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  // Remove a task
  void removeTask(Task task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }

  // Toggle task completion
  void toggleTaskCompletion(Task task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _saveTasks();
      notifyListeners();
    }
  }

  // Add a new category
  void addCategory(String category) {
    if (!_categories.contains(category) && category.isNotEmpty) {
      _categories.add(category);
      _saveCategories();
      notifyListeners();
    }
  }

  // Load tasks and categories from storage
  Future<void> _loadData() async {
    _tasks = await StorageService.loadTasks();
    _categories = await StorageService.loadCategories();
    _isInitialized = true;
    notifyListeners();
  }

  // Public method for explicit initialization
  Future<void> initialize() async {
    if (!_isInitialized) {
      await _loadData();
    }
  }

  // Save tasks to storage
  void _saveTasks() {
    StorageService.saveTasks(_tasks);
  }

  // Save categories to storage
  void _saveCategories() {
    StorageService.saveCategories(_categories);
  }

  // Get global taskList for backward compatibility
  List<Task> get taskList => _tasks;

  // Set taskList for backward compatibility
  set taskList(List<Task> tasks) {
    _tasks = tasks;
    _saveTasks();
    notifyListeners();
  }
}
