import 'package:flutter/material.dart';
import 'package:task_buddy/Screens/profile.dart';

import 'home_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex=0;
  List pages=[
    HomeScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex:selectedIndex,
        onDestinationSelected:(index){
          setState(() {
              selectedIndex=index;
          });
        },
        destinations: [
          NavigationDestination(icon:Icon(Icons.home,size:30),label:'Home',),
          NavigationDestination(icon:Icon(Icons.person,size:30),label:'Profile')
        ],
      ),
    );

  }
}
