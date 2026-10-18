import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String getgreeting() {
  int hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}
IconData getIcon(){
  int hour=DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return Icons.wb_sunny;
  } else if (hour >= 12 && hour < 17) {
    return Icons.wb_sunny_outlined;
  } else if (hour >= 17 && hour < 21) {
    return Icons.wb_twighlight;
  } else {
    return  Icons.nightlight_round;
  }
}
String ? userName;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TaskBuddy',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Color(0xff4d64ea),
        actions: [
          IconButton(
            onPressed: () {
              print('');
            },
            icon: Icon(Icons.search, size: 25, color: Color(0xffffffff)),
          ),
          IconButton(
            onPressed: () {
              print('');
            },
            icon: Icon(Icons.more_vert, size: 25, color: Color(0xffffffff)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Icon(getIcon(), color: Colors.yellow, size: 40),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(getgreeting(), style: TextStyle(fontSize: 22)),
                    Text(
                      '${userName ?? 'Guest'}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
