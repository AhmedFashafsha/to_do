import 'package:flutter/material.dart';
import 'package:to_do/pages/settings.dart';
import 'package:to_do/pages/tasks.dart';
import 'package:to_do/theme_manager.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: ThemeManager().themeData.scaffoldBackgroundColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 40),
        ListTile(
          contentPadding: EdgeInsets.only(top: 20, left: 16, right: 16),
          trailing: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).closeDrawer(),
              icon: Icon(Icons.arrow_forward),
            ),
          ),
          leading: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        Divider(),

        ListTile(
          leading: Icon(Icons.task),
          title: Text('Tasks'),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const Tasks()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const Settings()));
          },
        ),
      ],
    ),
  );
}
