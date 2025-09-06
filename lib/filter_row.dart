import 'package:flutter/material.dart';
import 'package:to_do/components.dart';
import 'package:to_do/task_manager.dart';
import 'package:to_do/theme_manager.dart';

class FilterRow extends StatefulWidget {
  final Function(Set<String>) onFilterChanged;

  const FilterRow({super.key, required this.onFilterChanged});

  @override
  _FilterRowState createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  Set<String> selectedFilters = {'All'}; // Track multiple selected filters

  void _handleFilterTap(String filter) {
    setState(() {
      if (filter == 'All') {
        // If "All" is selected, clear all other filters
        selectedFilters = {'All'};
      } else {
        // Remove "All" if any other filter is selected
        selectedFilters.remove('All');

        // Toggle the selected filter
        if (selectedFilters.contains(filter)) {
          selectedFilters.remove(filter);
        } else {
          selectedFilters.add(filter);
        }

        // If no filters are selected, default back to "All"
        if (selectedFilters.isEmpty) {
          selectedFilters = {'All'};
        }
      }

      // Notify parent widget about filter changes
      widget.onFilterChanged(selectedFilters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TaskManager(),
      builder: (context, child) {
        // Only show filters if TaskManager is initialized
        if (!TaskManager().isInitialized) {
          return Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Show "All" filter immediately since it's always available
                  buildFilterChip(
                    label: 'All',
                    selected: true,
                    onSelected: (selected) => {},
                  ),
                  SizedBox(width: 10),
                  // Show loading indicator for other filters
                  Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ThemeManager().themeData.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildFilterChip(
                label: 'All',
                selected: selectedFilters.contains('All'),
                onSelected: (selected) => _handleFilterTap('All'),
              ),
              SizedBox(width: 10),
              ...availableCategories.map((category) {
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: buildFilterChip(
                    label: category,
                    selected: selectedFilters.contains(category),
                    onSelected: (selected) => _handleFilterTap(category),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
