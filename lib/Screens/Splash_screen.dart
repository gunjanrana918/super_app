import 'dart:async';
import 'package:flutter/material.dart';
import 'package:super_app/Screens/Dashboard_screen.dart';
import 'package:super_app/universal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import '../Services/Login controller.dart';
import 'Login_screen.dart';

void main(){
  runApp(const MaterialApp(
    home: Splashscreen() ,
  ));
}
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late SharedPreferences sharedPreferences;
  bool? error;
  final LoginController obj = Get.put((LoginController()));
  getDataFromPref() async {
    final prefs = await SharedPreferences.getInstance();
    error= prefs.getBool('error') ;
    print(error);
  }


  @override
  void initState() {
    super.initState();
    getDataFromPref();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,MaterialPageRoute(
        builder: (context) =>error==false?Dashboard():LoginScreen()),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Container(
              height: 250,
              width:450,
              decoration: const BoxDecoration(
                //color: Colors.white,
                image: DecorationImage(
                  scale: 0.2,
                    image: AssetImage('images/logo-removebg-preview.png',),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}












