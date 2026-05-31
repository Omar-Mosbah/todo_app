import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // color: Colors.red,
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/unnamed.png",
                        width: 42,
                        height: 42,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Tasky',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Text(
                    "Welcome to Tasky ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your productivity journey starts here.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 24),
                  SvgPicture.asset(
                    "assets/images/pana.svg",
                    width: 215,
                    height: 205,
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: nameController,
                          // validate for empty ,
                          //length less than 3 and more than 50 characters ,
                          // not contain numbers or special characters
                          validator: (value) => value!.trim().isEmpty
                              ? "Name is required"
                              : value.trim().length < 3
                              ? "Name must be at least 3 characters"
                              : value.trim().length > 50
                              ? "Name must be less than 50 characters"
                              : RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())
                              ? null
                              : "Name must not contain numbers or special characters",
                          style: TextStyle(color: Colors.white),
                          // InputDecoration is used to style the TextField
                          decoration: InputDecoration(
                            hintText: "eg. Omar Mosbah",
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            // OutlineInputBoarder is used to set boarder radius for TextField
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                'username',
                                nameController.text.toString(),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF15B86C),
                            foregroundColor: Colors.white,
                            fixedSize: Size(360, 40),
                          ),
                          child: Text("Get Started"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
