import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ElevatedButton(
                onPressed: (){}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF15B86C),
                  foregroundColor: Colors.white,
                  fixedSize: Size(167, 40),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 6),
                    Text(
                      'Add New Task'),
                  ],
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
