import 'package:flutter/material.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({super.key});

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TodoTasks',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}