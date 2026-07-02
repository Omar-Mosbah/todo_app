import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Completed Tasks Screen', 
       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       );
  }
}