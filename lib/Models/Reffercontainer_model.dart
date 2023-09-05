// To parse this JSON data, do
//
//     final reffercontainerModel = reffercontainerModelFromJson(jsonString);

import 'dart:convert';

ReffercontainerModel reffercontainerModelFromJson(String str) => ReffercontainerModel.fromJson(json.decode(str));

String reffercontainerModelToJson(ReffercontainerModel data) => json.encode(data.toJson());

class ReffercontainerModel {
  List<IleTable> ileTable;

  ReffercontainerModel({
    required this.ileTable,
  });

  factory ReffercontainerModel.fromJson(Map<String, dynamic> json) => ReffercontainerModel(
    ileTable: List<IleTable>.from(json["ILETable"].map((x) => IleTable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ILETable": List<dynamic>.from(ileTable.map((x) => x.toJson())),
  };
}

class IleTable {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;

  IleTable({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
  });

  factory IleTable.fromJson(Map<String, dynamic> json) => IleTable(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
    arrivalDate: json["ArrivalDate"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "ArrivalDate": arrivalDate,
  };
}
