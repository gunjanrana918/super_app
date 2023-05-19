// To parse this JSON data, do
//
//     final imageupload = imageuploadFromJson(jsonString);

import 'dart:convert';

Imageupload imageuploadFromJson(String str) => Imageupload.fromJson(json.decode(str));

String imageuploadToJson(Imageupload data) => json.encode(data.toJson());

class Imageupload {
  List<IleTable> ileTable;

  Imageupload({
    required this.ileTable,
  });

  factory Imageupload.fromJson(Map<String, dynamic> json) => Imageupload(
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
