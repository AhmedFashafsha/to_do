import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/appbar.dart';
import 'package:to_do/drawer.dart';
import 'package:to_do/theme_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool dummyTaskCompleted = false;

  final Map<String, Color> themeColors = {
    'Default': Color.fromARGB(255, 154, 136, 232),
    'Blue': Color.fromARGB(255, 66, 133, 244),
    'Green': Color.fromARGB(255, 76, 175, 80),
    'Red': Color.fromARGB(255, 244, 66, 66),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Settings'),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: themeColors.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      ThemeManager().setTheme(entry.key);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: entry.value,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeManager().currentTheme == entry.key
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32),

            AnimatedOpacity(
              opacity: dummyTaskCompleted ? 0.7 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeColors[ThemeManager().currentTheme],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: dummyTaskCompleted
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: dummyTaskCompleted,
                        onChanged: (value) {
                          setState(() {
                            dummyTaskCompleted = value ?? false;
                          });
                        },
                        shape: CircleBorder(),
                        fillColor: WidgetStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return ThemeManager()
                                .themeData
                                .colorScheme
                                .secondary;
                          }
                          return Colors.transparent;
                        }),
                        checkColor:
                            ThemeManager().themeData.colorScheme.onSecondary,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Dummy Task',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                ThemeManager().themeData.colorScheme.onPrimary,
                            decoration: dummyTaskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor:
                                ThemeManager().themeData.colorScheme.onPrimary,
                            decorationThickness: 2.0,
                          ),
                        ),
                        subtitle: Text(
                          'This is a preview of a task',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeManager()
                                .themeData
                                .colorScheme
                                .onPrimary
                                .withValues(alpha: 0.8),
                            decoration: dummyTaskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: ThemeManager()
                                .themeData
                                .colorScheme
                                .onPrimary
                                .withValues(alpha: 0.8),
                          ),
                        ),
                        onTap: () {
                          // Handle task tap
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
