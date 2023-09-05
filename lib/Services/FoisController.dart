
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:super_app/Screens/RakeStatus_Screen.dart';
import '../Models/Fois_Rake.dart';


class RakestatusController extends GetxController{
  var isDataloading = false.obs;
  List<FoisRakeModel> rakepositionlist = [];
  var result;
  int index = 0;
  Rakestatusupdate(context) async{
    isDataloading(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/FoisRake'));
    request.body = json.encode({
      "RakeNo": "",

    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var validdata = FoisRakeModel .fromJson(jsonDecode(responseData));
      if(validdata.data[index].error==false){
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              rakeStatus(rakeuploaddata: validdata)));
          // code to be executed after 2 seconds
        });
        // Fluttertoast.showToast(
        //     msg:validdata.data[index].msg,
        //     gravity: ToastGravity.BOTTOM,
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: const Color(0xFF184f8d),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        return validdata;
      }
    else {
      Fluttertoast.showToast(
          msg:"Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }


    }
    else {
      Fluttertoast.showToast(
          msg:"Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }


  }
}
class detailRakestatusController extends GetxController{
  var isDataloading = false.obs;
  List<FoisRakeModel> rakepositionlistdetail = [];
  var result;
  int index = 0;
  detailRakestatus(context) async{
    isDataloading(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/FoisRake'));
    request.body = json.encode({
      "RakeNo": "",

    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var detaildatarake = FoisRakeModel .fromJson(jsonDecode(responseData));
      if(detaildatarake.data[index].error==false){
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              listrakeStatus(listrakedata: detaildatarake)));
          // code to be executed after 2 seconds
        });
        // Fluttertoast.showToast(
        //     msg:validdata.data[index].msg,
        //     gravity: ToastGravity.BOTTOM,
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: const Color(0xFF184f8d),
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        return detaildatarake;
      }
      else {
        Fluttertoast.showToast(
            msg:"Data not found",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF184f8d),
            textColor: Colors.white,
            fontSize: 16.0);
      }


    }
    else {
      Fluttertoast.showToast(
          msg:"Data not found",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xFF184f8d),
          textColor: Colors.white,
          fontSize: 16.0);
    }


  }
}




