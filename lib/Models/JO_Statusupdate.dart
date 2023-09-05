// To parse this JSON data, do
//
//     final jostatusupdate = jostatusupdateFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';
class jocontainer {
  bool error;
  String msg;
  String documentno;
  String containerNo;

  jocontainer({
    required this.error,
    required this.msg,
    required this.documentno,
    required this.containerNo,
  });
  factory jocontainer.fromJson(Map<String, dynamic> json) => jocontainer(
    error: json["error"],
    msg: json["msg"]!,
    documentno: json["Documentno"],
    containerNo: json["ContainerNo"],
  );
}

class getJOstatus{
  late List<jocontainer> jData;
  Future<List<jocontainer>?> loadjodata() async {
    jData =  <jocontainer>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/JoStatusUpdate'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var transitdata = parsedJson['Data'] as List;
      for (int i = 0; i < transitdata.length; ) {
        jData.add( jocontainer.fromJson(transitdata[i]));
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}

class User {
  final bool error;
  final String msg;
  final String documentno;
  final String containerNo;

  const User({
    required this.error,
    required this.msg,
    required this.documentno,
    required this.containerNo,
   // required this.name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
    error: json["error"],
    msg: json["msg"]!,
    documentno: json["Documentno"],
    containerNo: json["ContainerNo"],
  );
}

// class UserApi {
//    Future<List<User>> getUserSuggestions(String query) async {
//     final url = Uri.parse('http://103.25.130.254/grfl_login_api/Api/JoStatusUpdate?Location='+Globaldata.Location);
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final List users = json.decode(response.body['Data']);
//       return users.map((json) => User.fromJson(json)).where((user) {
//         final nameLower = user.containerNo.toLowerCase();
//         final queryLower = query.toLowerCase();
//
//         return nameLower.contains(queryLower);
//       }).toList();
//     } else {
//       throw Exception();
//     }
//   }
//
// }
