// To parse this JSON data, do
//
//     final joStatusSubmit = joStatusSubmitFromJson(jsonString);

import 'dart:convert';

JoStatusSubmit joStatusSubmitFromJson(String str) => JoStatusSubmit.fromJson(json.decode(str));

String joStatusSubmitToJson(JoStatusSubmit data) => json.encode(data.toJson());

class JoStatusSubmit {
  List<Datum> data;

  JoStatusSubmit({
    required this.data,
  });

  factory JoStatusSubmit.fromJson(Map<String, dynamic> json) => JoStatusSubmit(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String documentNo;
  dynamic conatinerNo;

  Datum({
    required this.error,
    required this.msg,
    required this.documentNo,
    required this.conatinerNo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    documentNo: json["DocumentNo"],
    conatinerNo: json["ConatinerNo"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "DocumentNo": documentNo,
    "ConatinerNo": conatinerNo,
  };
}
