import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // DateTime _selectedDay=DateTime.now();
  // DateTime _focusedDay=DateTime.now();
  DateTime _selectedDay=DateTime.now();
  DateTime _focusedDay=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Calender',style:TextStyle(
          fontWeight:FontWeight.w500,
            fontSize: 28, color: Colors.white),
        ),
        backgroundColor: const Color(0xff4d64ea),
        leading:IconButton(
          onPressed:(){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back,color:Colors.white),
        ),
        actions:[
          Icon(Icons.search,color:Colors.white),
          SizedBox(
            width:10,
          ),
          Icon(Icons.more_vert,color:Colors.white)
        ]
      ),
      body:Column(
        children:[
          ///Calender
          CalendarDatePicker(
            initialDate:_selectedDay,
            firstDate:DateTime(2000),
            lastDate:DateTime(3000),
            onDateChanged:(selectedDay){
              setState(() {
                _selectedDay=selectedDay;
                _focusedDay=selectedDay;
              });
            }
          )
        ]
      )
    );
  }
}
