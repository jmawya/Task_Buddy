import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay=DateTime.now();
  DateTime _fixedDay=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calender',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff4d64ea),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:Column(
        children:[
          CalendarDatePicker(
            initialDate: _selectedDay,
            firstDate: DateTime(2000),
            lastDate:DateTime(3000),
            onDateChanged:(selectedDay){
              setState(() {
                _selectedDay=selectedDay;
                _fixedDay=_selectedDay;
              });
            }
          )
        ]
      )
    );
  }
}

