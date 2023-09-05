
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/Screens/Dashboard_screen.dart';
import 'package:super_app/Screens/Privacypolicy_page.dart';
import 'package:super_app/Services/Login%20controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../universal.dart';
import 'Mobileotp_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red,
      // ignore: deprecated_member_use
      hintColor: Colors.deepOrange,
    ),
    home: const LoginScreen(),
  ));
}

late SharedPreferences localstorage;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
    Globaldata.Location= prefs.getString("Location")!;
    if (Globaldata.UserId.isNotEmpty) {
      Future.delayed(const Duration(seconds: 5), () {
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ));
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
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
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 13, right: 16.0),
                      child: TextFormField(
                        controller: obj.mobilecontroller,
                        decoration: const InputDecoration(
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
              const Padding(
                padding: EdgeInsets.all(15.0),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(left: 13, right: 16.0),
                  child: TextFormField(
                    controller: obj.passwordcontroller,
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
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
              const Padding(padding: EdgeInsets.only(top: 5.0)),
              //terms and condition checkbox
              Row(
                children: [
                  Container(
                    child: Expanded(
                      child: Material(
                        child:
                        Checkbox(
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
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle( fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF184f8d),),
                        text: 'I have read and agree with terms & conditions.',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Privacyscreen()));
                          }

                      ),
                    )

                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  // ignore: deprecated_member_use
                  child: SizedBox(
                    width: 280,
                    height: 50,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: const Color(0xFF184f8d),
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
                              backgroundColor: const Color(0xFF184f8d),
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
                              backgroundColor: const Color(0xFF184f8d),
                              textColor: Colors.white,
                              fontSize: 16.0);}
                        // }
                          else {
                          obj.loginbutton(context);
                        }
                      },
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(top: 10, right: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MobileOTP()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF184f8d),
                             fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer()
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
