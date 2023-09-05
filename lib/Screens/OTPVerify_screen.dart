import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../Services/Login controller.dart';
import 'Makenewpassword_screen.dart';
class OTPVerify extends StatefulWidget {
  const OTPVerify({Key? key}) : super(key: key);

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final OTPValidationcontroller OTPobj = Get.put(OTPValidationcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        // titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        // elevation: 0,
        backgroundColor: const Color(0xFF184f8d),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Text("Verification"),
                  Text(
                    "We have sent OTP on +919528166211",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Text(
                  //   "+919528166211",
                  //   style: TextStyle(fontWeight: FontWeight.w500),
                  // )
                ],
              ),
            ),
            Center(
              child: PinFieldAutoFill(
                codeLength: 4,
                autoFocus: true,
                decoration: UnderlineDecoration(
                  lineHeight: 2,
                  lineStrokeCap: StrokeCap.square,
                  bgColorBuilder: PinListenColorBuilder(
                      Colors.green.shade200, Colors.grey.shade200),
                  colorBuilder: const FixedColorBuilder(Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SizedBox(
                //   height: 46,
                //   width: 120,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Color(0xFF184f8d)),
                //     ),
                //     onPressed: () async {
                //       OTPobj.MobileOTP();
                //     },
                //     child: const Text("Resend",style: TextStyle(fontSize: 18),),
                //   ),
                // ),
                SizedBox(
                  height: 46,
                  width: 120,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF184f8d)),
                    ),
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const Newpassword()));
                    } ,
                    child: const Text("Submit",style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
