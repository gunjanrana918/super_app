// To parse this JSON data, do
//
//     final submitcontainerdata = submitcontainerdataFromJson(jsonString);

import 'dart:convert';

Submitcontainerdata submitcontainerdataFromJson(String str) => Submitcontainerdata.fromJson(json.decode(str));

String submitcontainerdataToJson(Submitcontainerdata data) => json.encode(data.toJson());

class Submitcontainerdata {
  List<Datum> data;

  Submitcontainerdata({
    required this.data,
  });

  factory Submitcontainerdata.fromJson(Map<String, dynamic> json) => Submitcontainerdata(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  dynamic containerNo;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
  };
}
