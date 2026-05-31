import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Prepare the breakfast for tommorow',
                  hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                  filled: true,
                  fillColor: Color(0xFF282828),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                  ),
                ),
              )
            ],
          ),
        ),
        ),
    );
  }
}