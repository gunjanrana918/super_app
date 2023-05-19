import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/binding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/Screens/Dashboard_screen.dart';
import 'package:super_app/Screens/Privacypolicy_page.dart';
import 'package:super_app/Services/Login%20controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../universal.dart';
import 'Mobileotp_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red,
      // ignore: deprecated_member_use
      accentColor: Colors.deepOrange,
    ),
    home: LoginScreen(),
  ));
}

late SharedPreferences localstorage;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static init() async {
    localstorage = await SharedPreferences.getInstance();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool ishiddenpassword = false;
  bool isObsecure = true;
  final mobilecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  late SharedPreferences? logindata = null;
  late SharedPreferences sharedPreferences;
  Future<void> main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Globaldata.DisplayName = prefs.getString('msg')!;
    Globaldata.UserId = prefs.getString("UserId")!;
    Globaldata.Password = prefs.getString("Password")!;
    if (Globaldata.UserId.isNotEmpty) {
      Future.delayed(Duration(seconds: 5), () {
        print("Executed after 5 seconds");
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    main();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobilecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

// ignore: non_constant_identifier_names
  bool agree = false;
  bool showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    final LoginController obj = Get.put((LoginController()));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                height: 120,
                width: 130,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/logo-removebg-preview.png',
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 13, right: 16.0),
                      child: TextFormField(
                        controller: obj.mobilecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'User Id',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 13, right: 16.0),
                  child: TextFormField(
                    controller: obj.passwordcontroller,
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          isObsecure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onTap: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                      ),
                    ),
                  ),
                )),
              ]),
              Padding(padding: EdgeInsets.only(top: 5.0)),
              //terms and condition checkbox
              Row(
                children: [
                  Container(
                    child: Expanded(
                      child: Material(
                        child: Checkbox(
                          checkColor: Colors.red,
                          value: agree,
                          onChanged: (newValue) {
                            setState(() => agree = newValue!);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle( fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF184f8d),decoration: TextDecoration.underline),
                        text: 'I have read and accept terms and conditions.',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Privacyscreen()));
                          }

                      ),
                    )

                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  // ignore: deprecated_member_use
                  child: Container(
                    width: 280,
                    height: 50,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Color(0xFF184f8d),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (obj.mobilecontroller.text.isEmpty &&
                            obj.passwordcontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter valid credentials!",
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color(0xFF184f8d),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        else if (agree != true) {
                          Fluttertoast.showToast(
                              msg:
                              "Please accept the terms and conditions to proceed...",
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color(0xFF184f8d),
                              textColor: Colors.white,
                              fontSize: 16.0);}
                        // }
                          else {
                          obj.loginbutton(context);
                        }
                      },
                    ),
                  )),
              Padding(padding: EdgeInsets.only(top: 10, right: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MobileOTP()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF184f8d),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      ishiddenpassword = !ishiddenpassword;
    });
  }
}
