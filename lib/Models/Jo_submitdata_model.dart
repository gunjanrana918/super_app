// To parse this JSON data, do
//
//     final joDatasubmit = joDatasubmitFromJson(jsonString);

import 'dart:convert';

JoDatasubmit joDatasubmitFromJson(String str) => JoDatasubmit.fromJson(json.decode(str));

String joDatasubmitToJson(JoDatasubmit data) => json.encode(data.toJson());

class JoDatasubmit {
  List<Datum> data;

  JoDatasubmit({
    required this.data,
  });

  factory JoDatasubmit.fromJson(Map<String, dynamic> json) => JoDatasubmit(
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

  Datum({
    required this.error,
    required this.msg,
    required this.documentNo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    documentNo: json["DocumentNo"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "DocumentNo": documentNo,
  };
}
