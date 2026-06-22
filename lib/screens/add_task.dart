import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/home_screen.dart';


class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

final TextEditingController taskNameController = TextEditingController();
final TextEditingController taskDescController = TextEditingController();
final GlobalKey<FormState> _key = GlobalKey<FormState>();
bool isHighPriority = true;

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: taskNameController,
                          validator: (value) =>
                              value!.trim().isEmpty ? "Waot" : null,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Prepare the breakfast for tommorow',
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Task Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: taskDescController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please write description";
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Descripe your task ...',
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              'High Priority',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Switch(
                              value: isHighPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                              activeThumbColor: Colors.white,
                              activeTrackColor: Color(0xFF15B86C),
                            ),
                          ],
                        ),

                        // Spacer(),
                      ],
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final task = Task(
                        taskName: taskNameController.text,
                        taskDescription: taskDescController.text,
                        isHighPriority: isHighPriority,
                      );
                      final pref = await SharedPreferences.getInstance();
                      String? savedTask = pref.getString("tasks");
                      List<dynamic> tasksList = [];
                      if (savedTask != null) {
                        tasksList = jsonDecode(savedTask);
                        print(tasksList.runtimeType);
                        print('find:$tasksList');
                      }
                      tasksList.add(task.toJson());
                      print('after adding:$tasksList');
                      final encodedTasksList = jsonEncode(tasksList);
                      await pref.setString("tasks", encodedTasksList);
                      taskNameController.clear();
                      taskDescController.clear();
                      isHighPriority = true;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF15B86C),
                    fixedSize: Size(MediaQuery.of(context).size.width, 12),
                  ),
                  icon: Icon(Icons.add),
                  label: Text('Add Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
