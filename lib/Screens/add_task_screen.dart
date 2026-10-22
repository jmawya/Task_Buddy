import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final TextEditingController taskController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> pickDate()  async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void saveTask() {
    final text = taskController.text.trim();

    if (text.isEmpty) return;

    Navigator.pop(context, {
      'title': text,
      'date': selectedDate,
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor:  Color(0xff7b51ff),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),


            TextField(
              controller:taskController,
              maxLines:10,
              decoration:InputDecoration(
                hintText:'Write your task here...',
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(10))
                )
              )
            ),


            const SizedBox(height: 20),

            ListTile(
              leading:Icon(Icons.calendar_month,size:35, color:Color(0xff770d0d)),
              title:Text('Due Date'),
              subtitle:Text('${selectedDate.day}/'
                  '${selectedDate.month}/'
                  '${selectedDate.year}'
                  ),
              onTap:pickDate,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width:double.infinity,
              child:ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor:Color(0xffa690ea),
                  foregroundColor:Colors.white,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                
                onPressed:saveTask,
                child: Text('Save Task',style:TextStyle(
                  fontSize:20
                ))
              )

            )
          ],
        ),
      ),
    );
  }
}