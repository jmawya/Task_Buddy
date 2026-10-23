import 'package:flutter/material.dart';
import 'Screens/main_home_screen.dart';
import 'Screens/profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
    valueListenable:themeNotifier,
    builder: (context, mode, _) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'Task buddy',
    home: MainHomeScreen(),
    theme: ThemeData.light(),
    darkTheme:ThemeData.dark(),
    themeMode:mode,
    );
    },
    );
  }
}