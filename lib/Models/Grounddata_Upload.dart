// To parse this JSON data, do
//
//     final grounddataupload = grounddatauploadFromJson(jsonString);

import 'dart:convert';

Grounddataupload grounddatauploadFromJson(String str) => Grounddataupload.fromJson(json.decode(str));

String grounddatauploadToJson(Grounddataupload data) => json.encode(data.toJson());

class Grounddataupload {
  List<IleTable> ileTable;

  Grounddataupload({
    required this.ileTable,
  });

  factory Grounddataupload.fromJson(Map<String, dynamic> json) => Grounddataupload(
    ileTable: List<IleTable>.from(json["ILETable"].map((x) => IleTable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ILETable": List<dynamic>.from(ileTable.map((x) => x.toJson())),
  };
}

class IleTable {
  bool error;
  String msg;

  IleTable({
    required this.error,
    required this.msg,
  });

  factory IleTable.fromJson(Map<String, dynamic> json) => IleTable(
    error: json["error"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
  };
}
