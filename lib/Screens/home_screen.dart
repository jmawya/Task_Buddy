import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('TaskBuddy',style:TextStyle(
          fontSize:28,
          color:Colors.white
        )),
        backgroundColor:Color(0xff4d64ea),
        actions:[IconButton(
          onPressed:(){
            print('');
          },icon:Icon(
            Icons.search,size:25,color:Color(0xffffffff))
        ),
          IconButton(
              onPressed:(){
                print('');
              },icon:
          Icon(Icons.more_vert,
              size:25,
              color:Color(0xffffffff))
          ),
        ]
        )


    );
  }
}
