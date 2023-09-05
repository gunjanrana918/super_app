import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/Screens/Dashboard_screen.dart';
import 'package:super_app/universal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:splashscreen/splashscreen.dart';

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

  startTimer() {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    internetCheck();
    Navigator.pushReplacement(
      context,MaterialPageRoute(
        builder: (context) =>error==false?Dashboard():LoginScreen()),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Container(
              height: 150,
              width:250,
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
  internetCheck() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      Fluttertoast.showToast(
          msg: 'Check your Internet',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Fluttertoast.showToast(
          msg: 'Check your Internet',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else{
      Fluttertoast.showToast(
          msg: 'Please connected to internet',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}












