import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/main_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  String? username = pref.getString('username');
  runApp(MyApp(name: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});
  final String? name;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //colorScheme: ColorScheme.dark(),
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF181818),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor:Color(0xFF181818)),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF181818),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),)
        ),
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      home: name == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
