
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../Models/Container_validation model.dart';
import '../Models/EIR models.dart';


class ContainerValidate extends GetxController{
  var isDataloading = false.obs;
  final datepicker = TextEditingController();
  final containercontroller = TextEditingController();
  List<ValidContainer> list = [];
  var result;
  int index = 0;
  Validation_container() async{
    isDataloading(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Checkcontainer'));
    request.body = json.encode({
      "ContainerNo": containercontroller.text,

    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print(responseData);
      var validdata = ValidContainer .fromJson(jsonDecode(responseData));

      return validdata;

    }
    else {
      Fluttertoast.showToast(
          msg: "EIR Copy not received!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print(response.reasonPhrase);
    }


  }
}



