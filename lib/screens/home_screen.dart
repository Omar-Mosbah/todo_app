import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<dynamic> tasksDecoded = [];
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
    setState(() {
      final task = pref.getString('tasks');
      print('tasks from pref:$task');
      tasksDecoded = jsonDecode(task ?? "[]");
      // write a print statment to view the type of the tasksDecoded variable
      print('Type of tasksDecoded: ${jsonDecode(task ?? "[]").runtimeType}');
      print('tasks decoded:$tasksDecoded');
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
            ],
          ),
        ),
      ),
    );
  }
}
