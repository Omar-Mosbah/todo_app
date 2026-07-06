import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/tasks_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<Task> taskMapped = [];
  // bool isDone = false;
  // bool isLoading = true;
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
    // await Future.delayed(Duration(seconds: 10));
    final pref = await SharedPreferences.getInstance();
    
    // Load tasks from SharedPreferences the format is a String
    final task = pref.getString('tasks');
    print('tasks from pref:$task');
    if (task != null) {
      final List<dynamic> tasksDecoded = jsonDecode(task);
      print('tasks decoded:$tasksDecoded');
      taskMapped = tasksDecoded
          .map((element) => Task.fromJson(element))
          .toList();
    }
    ;
    setState(() {
      taskMapped;
      // isLoading = false;
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
          foregroundColor: Color(0xFFFFFCFC),
          icon: Icon(Icons.add),
          label: Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              SizedBox(height: 24),
              Text(
                "My Tasks",
                style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
              ),
              if (taskMapped.isNotEmpty) SizedBox(height: 16),
              // isLoading ? Expanded(
              //   child: Center(child: CircularProgressIndicator()),
              // ) :
              Expanded(
                child: TasksListWidget(
                  task: taskMapped,
                  onTaskChanged: (bool? value, index) async {
                    setState(() {
                      taskMapped[index!].isDone = value ?? false;
                    });
                    // get instance at the need i will set string will the new list
                    // all values is modified together.
                    final pref = await SharedPreferences.getInstance();
                    // the task is now list of Task instance []
                    print('$taskMapped');
                    final List<dynamic> taskUpdate = taskMapped
                        .map((taskInst) => taskInst.toJson())
                        .toList();
                    // the taskUpdate is now list of json files []
                    print('$taskUpdate');
                    pref.setString("tasks", jsonEncode(taskMapped));
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
