import 'package:flutter/material.dart';
import 'Screens/main_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task buddy',
      home:  MainHomeScreen()
    );
  }
}
