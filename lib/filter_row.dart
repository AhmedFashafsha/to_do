import 'package:flutter/material.dart';
import 'package:to_do/components.dart';

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
  }
}
