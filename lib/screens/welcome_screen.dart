import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/unnamed.png",
                    width: 42,
                    height: 42,),
                    SizedBox(width: 16,),
                    Text(
                      'Tasky',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                    ),
                    ),  
                  ],
                ),
                SizedBox(height:108,),
                Text("Welcome to Tasky ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(height:8,),
                Text("Your productivity journey starts here.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(height:24,),
                SvgPicture.asset("assets/images/pana.svg",
                width: 215,
                height: 205,),
                SizedBox(height:24,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Full Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),),
                      TextField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: "eg. Omar Mosbah",
                          hintStyle: TextStyle(
                            color: Color(0xFF6D6D6D)
                          ),
                          filled: true,
                          fillColor: Color(0xFF282828),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                      SizedBox(height:24,),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF15B86C),
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Get Started")),
                    ],
                  ),
                )
              ],
            ),
          ),
          ),
        
      );
  }
}