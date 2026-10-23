import 'package:flutter/material.dart';
import 'home_screen.dart';

// This remembers if dark mode is on or off
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> clearTasks(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all tasks?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (ok == true) {
      tasks.clear();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All tasks cleared')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff7b51ff),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // 1. Dark mode
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) => SwitchListTile(
              title: const Text('Dark mode'),
              secondary: const Icon(Icons.dark_mode),
              value: mode == ThemeMode.dark,
              onChanged: (isOn) {
                themeNotifier.value = isOn ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),

          // 2. Clear all tasks
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Clear all tasks'),
            onTap: () => clearTasks(context),
          ),

          // 3. About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'TaskBuddy',
                applicationVersion: '1.0.0',
                children: const [
                  Text('A simple app to add and search your daily tasks.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}