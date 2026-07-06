import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/tasks_list_widget.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({super.key});

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  List<Task> taskMapped = [];
  void initState() {
    super.initState();
    _loadTasks();
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
      taskMapped = taskMapped.where((task) => task.isDone == false).toList();
      // isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TasksListWidget(
          task: taskMapped,
          onTaskChanged: (value, index) async {
            setState(() {
              taskMapped[index!].isDone = value ?? false;
              Future.delayed(Duration(milliseconds: 500), () {
                _loadTasks();
              });
            });
            final pref = await SharedPreferences.getInstance();
            
            // the taskUpdate is now list of json files []
            final List<dynamic> All_data = jsonDecode(
              pref.getString("tasks") ?? '[]',
            );
            final List<Task> All_data_task = All_data.map(
              (jsonTask) => Task.fromJson(jsonTask),
            ).toList();
            // what is the index of the task that is modified in the All_data_task list
            final newIndex = All_data_task.indexWhere(
              (task) => task.taskName == taskMapped[index!].taskName,
            );
            All_data_task[newIndex] = taskMapped[index!];
            pref.setString("tasks", jsonEncode(taskMapped));
          },
        ),
      ),
    );
  }
}
