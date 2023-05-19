import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/Screens/Login_screen.dart';

import '../Models/ChanngePWD.dart';
import '../Services/Login controller.dart';

class Changemypassword extends StatefulWidget {
  const Changemypassword({Key? key}) : super(key: key);

  @override
  State<Changemypassword> createState() => _ChangemypasswordState();
}

class _ChangemypasswordState extends State<Changemypassword> {
  final Changepasswordcontroller updatepassword =
      Get.put(Changepasswordcontroller());
  Changepassword? passcode;
  bool ishiddenpassword = false;
  bool isObsecure = true;
  bool isObsecures = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
        ),
        //centerTitle: true,
        backgroundColor: Color(0xFF184f8d),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Expanded(
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: updatepassword.newpasswordcontroller,
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      hintText: 'Enter new password',
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
                    )),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Expanded(
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: updatepassword.confirmpasswordcontroller,
                    obscureText: isObsecures,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'Enter confirm password',
                        suffixIcon: GestureDetector(
                            child: Icon(
                              isObsecures
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onTap: () {
                              setState(() {
                                isObsecures = !isObsecures;
                              });
                            }))),
              ),
            ]),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          // ignore: deprecated_member_use
          MaterialButton(
              color: Color(0xFF184f8d),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () async {
                 if (updatepassword.newpasswordcontroller.text.length == 0) {
                  Fluttertoast.showToast(
                      msg: "Enter new password",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                } else if (updatepassword.confirmpasswordcontroller.text.length == 0) {
                  Fluttertoast.showToast(
                      msg: "Enter confirm password",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  return;
                } else if (updatepassword.newpasswordcontroller.text !=
                    updatepassword.confirmpasswordcontroller.text) {
                  Fluttertoast.showToast(
                      msg: "New password and Confirm password does not match",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  // ignore: deprecated_member_use
                  return;
                }
                else{
                  passcode = await updatepassword.resetpassword();
                  updatepassword.newmobilecontroller.clear();
                  updatepassword.newpasswordcontroller.clear();
                  updatepassword.confirmpasswordcontroller.clear();
                  SharedPreferences preferences =
                  await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              })
        ],
      ),
    );
  }
}
