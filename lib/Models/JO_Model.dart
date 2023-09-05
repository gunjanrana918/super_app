// To parse this JSON data, do
//
//     final joData = joDataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class jovalue {
  bool error;
  String msg;
  String documentno;
  String location;

  jovalue({
    required this.error,
    required this.msg,
    required this.documentno,
    required this.location,
  });

  factory jovalue.fromJson(Map<String, dynamic> json) => jovalue(
    error: json["error"],
    msg: json["msg"]!,
    documentno: json["Documentno"],
    location: json["Location"]!,
  );
}
class joData{
  late List<jovalue> myData;
  Future<String?> loadjodata() async {
    myData =  <jovalue>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/Getjono'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var jdata = parsedJson['Data'] as List;
      for (int i = 0; i < jdata.length; i++) {
        myData.add( jovalue.fromJson(jdata[i]));
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}


