import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/tasks_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<Task> tasksList = [];

  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final pref = await SharedPreferences.getInstance();
    List<dynamic> savedTasks = jsonDecode(pref.getString('tasks') ?? "");
    if (savedTasks.isNotEmpty) {
      setState(() {
        tasksList = savedTasks.map((task) => Task.fromJson(task)).toList();
        tasksList = tasksList
            .where((element) => element.isDone == true)
            .toList();
        print(tasksList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: tasksList.isEmpty
          ? Center(
              child: Text(
                "No completed tasks yet.",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : TasksListWidget(
              task: tasksList,
              onTaskChanged: (value, index) async {
                setState(() {
                  tasksList[index!].isDone = value ?? false;
                  
                });
                final pref = await SharedPreferences.getInstance();
                List<dynamic> allTasks = jsonDecode(
                  pref.getString('tasks') ?? "",
                );
                final List<Task> allTasksList = allTasks
                    .map((e) => Task.fromJson(e))
                    .toList();
                final currentIndex = allTasksList.indexWhere(
                  (e) => e.taskName == tasksList[index!].taskName,
                );
                allTasksList[currentIndex] = tasksList[index!];
                pref.setString('tasks', jsonEncode(allTasksList));
                _loadTask();
              },
            ),
    );
  }
}
