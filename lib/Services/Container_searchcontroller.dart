

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/universal.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Models/ILE_Models.dart';
import '../Models/Node_containersearch.dart';

class DataController extends GetxController {
  // Userdata? userdata;
  var isDataloading = false.obs;
  final containercontroller = TextEditingController();
  int index = 0;

  List<AutoGenerate> list = [];

  importArrival() async {

    // AutoGenerate  autoGenerate;
    var headers = {
      'X-RapidAPI-Host': 'youtube-music1.p.rapidapi.com',
      'X-RapidAPI-Key': 'cca4489800msh3eea4083dd3bb5ep1c3db3jsn57f848d89020',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ImpArrivalInfo'));
    request.body = '''{\r\n    "ContainerNo" : "${containercontroller.text.trim()}"}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print(responseData);
      var autoGenerate =
      AutoGenerate .fromJson(jsonDecode(responseData));

      return autoGenerate;

    }
    else {
      Fluttertoast.showToast(
          msg: "Data Not Found!",
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

class ILEController extends GetxController{
  var isDataloading = false.obs;
  final searchcontroller = TextEditingController();
  String? selectedvalue;
  List<Welcome> list = [];
  var searchdata;
  var autoGenerate;

  searchIlE() async {
    int index=0;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ILESearch'));
    request.body = json.encode({

      "ContainerNo": searchcontroller.text,
      "ActivityType": selectedvalue.toString(),
      "Remarks":""
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    try{
      if (response.statusCode == 200) {
         autoGenerate = Welcome.fromJson(jsonDecode(responseData));
        var searchdatamessage  = autoGenerate.msg;
        var containerno = autoGenerate.data[index].containerNo;
        var activity = autoGenerate.data[index].activityType;
        Globaldata.activitytype= activity;
        Globaldata.ContainerNo = containerno;
        Globaldata.containersearchmessage = searchdatamessage;
        print("????????");
        print(Globaldata.containersearchmessage);
        Fluttertoast.showToast(
            msg: Globaldata.containersearchmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        print("autoGenerate");
        print(autoGenerate);
        return autoGenerate;

      }
      else {
        Fluttertoast.showToast(
            msg: Globaldata.containersearchmessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
        print(response.reasonPhrase);
      }
    }
    catch(e){
      print("errrorrrrrrrrrrrr");
      print(e);
    }
  }

}






