import 'package:flutter/material.dart';
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
    backgroundColor: themeData.colorScheme.secondary,
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
  );
}

SingleChildScrollView buildFilterRow() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        buildFilterChip(
          label: 'All',
          selected: false,
          onSelected: (selected) {},
        ),
        buildFilterChip(
          label: 'Active',
          selected: false,
          onSelected: (selected) {},
        ),
        buildFilterChip(
          label: 'Completed',
          selected: false,
          onSelected: (selected) {},
        ),
      ],
    ),
  );
}
