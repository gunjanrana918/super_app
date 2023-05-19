// To parse this JSON data, do
//
//     final validContainer = validContainerFromJson(jsonString);

import 'dart:convert';

ValidContainer validContainerFromJson(String str) => ValidContainer.fromJson(json.decode(str));

String validContainerToJson(ValidContainer data) => json.encode(data.toJson());

class ValidContainer {
  ValidContainer({
    required this.ileTable,
  });

  List<IleTable> ileTable;

  factory ValidContainer.fromJson(Map<String, dynamic> json) => ValidContainer(
    ileTable: List<IleTable>.from(json["ILETable"].map((x) => IleTable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ILETable": List<dynamic>.from(ileTable.map((x) => x.toJson())),
  };
}

class IleTable {
  IleTable({
    required this.error,
    required this.msg,
    required this.containerNo,
  });

  bool error;
  String msg;
  String containerNo;

  factory IleTable.fromJson(Map<String, dynamic> json) => IleTable(
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
