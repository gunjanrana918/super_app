// To parse this JSON data, do
//
//     final gRdetail = gRdetailFromJson(jsonString);

import 'dart:convert';

GRdetail gRdetailFromJson(String str) => GRdetail.fromJson(json.decode(str));

String gRdetailToJson(GRdetail data) => json.encode(data.toJson());

class GRdetail {
  List<Datum> data;

  GRdetail({
    required this.data,
  });

  factory GRdetail.fromJson(Map<String, dynamic> json) => GRdetail(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String location;
  String rakeNo;

  Datum({
    required this.error,
    required this.msg,
    required this.location,
    required this.rakeNo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    location: json["Location"],
    rakeNo: json["RakeNo"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "Location": location,
    "RakeNo": rakeNo,
  };
}
