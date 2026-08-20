import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/Text_field_Widgets.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
   const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title:  Text(
          'To Do App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Column(
            children: [

               SizedBox(height: 20),

              Lottie.asset(
                "assets/New Google Keep Icon.json",
                width: 230,
                height: 280,
              ),

               SizedBox(height: 15),

               Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2D2438),
                ),
              ),

               SizedBox(height: 8),

               Text(
                'Enter your name to start organizing your tasks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

               SizedBox(height: 30),

              TextfieldWidgets(
                controller: nameController,
                vali: 'Please enter your name',
                hint: 'Your Name',
              ),

               SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () async {
                    final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                    prefs.setString('username', nameController.text);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },

                  child:  Text(
                    'Start',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

               Spacer(),

               Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Ahmed Abbas",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}