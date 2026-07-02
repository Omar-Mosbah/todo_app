import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/screens/completed_tasks_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/profile_screen.dart';
import 'package:todo_app/screens/todo_tasks.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<Widget> Screens = [
  HomeScreen(),
  TodoTasks(),
  CompletedTasksScreen(),
  Profile(),
];

int _currentIndex = 0;

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        selectedItemColor: Color(0xFF15B86C),
        unselectedItemColor: Color(0xFFC6C6C6),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home.svg',
            colorFilter: ColorFilter.mode(
              _currentIndex == 0 ?
              Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn),),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/todo.svg',
            colorFilter: ColorFilter.mode(
              _currentIndex == 1 ?
              Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn),
            ),
            label: 'To Do',
            
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/completedtasks.svg',
            colorFilter: ColorFilter.mode(
              _currentIndex == 2 ?
              Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn),),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/profile.svg',
            colorFilter: ColorFilter.mode(
              _currentIndex == 3 ?
              Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn),),
            label: 'Profile',
          ),
        ],
      ),
    body: Screens[_currentIndex],
    );
  }
}
