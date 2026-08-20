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
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: Text('To Do App'),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Lottie.asset("assets/New Google Keep Icon.json", width: 300, height: 400),

          SizedBox(height: 40),

          TextfieldWidgets(
            controller: nameController,
            vali: 'Please enter your name',
            hint: 'Your Name',
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('username', nameController.text);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child:
            Text('Start' ,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
          ),
          SizedBox(height: 200),

          Text("Ahmed Abbas")
        ],
      ),
    );
  }
}