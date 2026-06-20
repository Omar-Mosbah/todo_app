import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<Task> taskMapped = [];
  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTasks();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('username');
    });
  }

  void _loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    // Load tasks from SharedPreferences the format is a String
    final task = pref.getString('tasks');
    print('tasks from pref:$task');
    if (task != null) {
      final List<dynamic> tasksDecoded = jsonDecode(task);
      taskMapped = tasksDecoded
          .map((element) => Task.fromJson(element))
          .toList();
    }
    ;
    setState(() {
      taskMapped;
      print('tasks decoded:$taskMapped');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
          },
          backgroundColor: Color(0xFF15B86C),
          icon: Icon(Icons.add),
          label: Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/unnamed.png"),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening, ${name != null ? name!.substring(0, 1).toUpperCase() + name!.substring(1) : 'Guest'}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 255, 252, 252),
                        ),
                      ),
                      Text(
                        "One task at a time.One step closer.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (taskMapped.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: taskMapped.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.center,
                          height: 54,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueGrey,
                          ),
                          child: Text(
                            '${taskMapped[index].taskName}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
