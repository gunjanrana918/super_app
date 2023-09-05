import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_app/Services/Login%20controller.dart';

import '../Models/OTP_Modalclass.dart';
import 'OTPVerify_screen.dart';
class MobileOTP extends StatefulWidget {
  const MobileOTP({Key? key}) : super(key: key);

  @override
  State<MobileOTP> createState() => _MobileOTPState();
}

class _MobileOTPState extends State<MobileOTP> {
  final TextEditingController mobiletextcontroller = TextEditingController();
  final OTPValidationcontroller OTPobj = Get.put(OTPValidationcontroller());
  OtpValidation? otpmodal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF184f8d),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40.0,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:  Row(children: <Widget>[
              Expanded(
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: OTPobj.mobiletextcontroller,
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      hintText: 'Enter mobile No.',
                    )),
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(top: 30.0)),
          // ignore: deprecated_member_use
          MaterialButton(
              color: const Color(0xFF184f8d),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () async {
                if(OTPobj.mobiletextcontroller.text.isEmpty){
                  Fluttertoast.showToast(
                      msg: "Enter 10 digit Mobile no",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 15.0);
                }
                else  {
                  OTPobj.MobileOTP();
                  //OTPobj.mobiletextcontroller.clear();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const OTPVerify()));
                }
              })
        ],
      ),
    );
  }
}
