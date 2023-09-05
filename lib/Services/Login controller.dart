import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/universal.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ChanngePWD.dart';
import '../Models/OTP_Modalclass.dart';
import '../Models/userdata.dart';
import '../Screens/Dashboard_screen.dart';

class LoginController extends GetxController{
  var isDataloading = false.obs;
  final mobilecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  List<Welcome> list = [];
  Welcome?welcome;
  var error= ' error'.obs;

  loginbutton(context) async {
    int index = 0;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isDataloading(true);
    http.Response response = await http.post(
        Uri.tryParse('http://103.25.130.254/grfl_login_api/Api/SupperAppLogin')!,
        body: {
          "UserId": mobilecontroller.text,
          "Password": passwordcontroller.text,
        });
    try {
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var logdetails = Welcome.fromJson((result));
        var loginmessage = logdetails.login[index].msg;
        Globaldata.loginmessage = loginmessage;
        if(logdetails.login[index].error==false)
        {
          sharedPreferences.setString('msg',logdetails.login[index].msg );
          sharedPreferences.setString('UserId',logdetails.login[index].userId );
          sharedPreferences.setString('Password',logdetails.login[index].password );
          sharedPreferences.setString('Location',logdetails.login[index].location );
          var username = sharedPreferences.getString('msg');
          Globaldata.DisplayName = username.toString();
          var userid = sharedPreferences.getString('UserId');
          Globaldata.UserId = userid.toString();
          var password = sharedPreferences.getString("Password");
          Globaldata.Password = password.toString();
          var location = sharedPreferences.getString("Location");
          Globaldata.Location= location.toString();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
              const Dashboard(),));
          mobilecontroller.clear();
          passwordcontroller.clear();
        }
        else {
          Fluttertoast.showToast(
              msg:  Globaldata.loginmessage,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 2,
              backgroundColor: const Color(0xFF184f8d),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
      else{
        Fluttertoast.showToast(
            msg: Globaldata.loginmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    catch(e){
      Fluttertoast.showToast(
          msg: Globaldata.loginmessage,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    }

  }

  //Reset password API/////
class Changepasswordcontroller extends GetxController {
  final newmobilecontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  var isLoading = true.obs;
  List<Changepassword> list = [];
  var error = 'error'.obs;
  var mynewpassword;
  resetpassword() async {
    int index=0;
    isLoading(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://103.25.130.254/grfl_login_api/Api/forgotpwd'));
    request.body = json.encode({
      "UserId": Globaldata.UserId,
      "Password": confirmpasswordcontroller.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var newotppasword = Changepassword.fromJson(jsonDecode(responseData));
      mynewpassword = newotppasword.resetpwd[index].msg;
      Fluttertoast.showToast(
          msg:mynewpassword,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
      return newotppasword;
    }
    else {
      Fluttertoast.showToast(
          msg:mynewpassword,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

//OTP Validation API////
class OTPValidationcontroller extends GetxController{
  final TextEditingController mobiletextcontroller = TextEditingController();
  List<OtpValidation> list = [];
  var Mynewotp;
  MobileOTP() async {
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://103.25.130.254/grfl_login_api/Api/otp'));
    request.body = json.encode({
      "UserId": mobiletextcontroller.text,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var newotpresponse = OtpValidation.fromJson(jsonDecode(responseData));
     Mynewotp = newotpresponse.login[index].msg;
     Globaldata.UserId = newotpresponse.login[index].userId;
      // Fluttertoast.showToast(
      //     msg:Mynewotp,
      //     gravity: ToastGravity.BOTTOM,
      //     toastLength: Toast.LENGTH_LONG,
      //     timeInSecForIosWeb: 5,
      //     backgroundColor: Color(0xFF184f8d),
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      return newotpresponse;
    }
    else {
      Fluttertoast.showToast(
          msg:Mynewotp,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }




}

















