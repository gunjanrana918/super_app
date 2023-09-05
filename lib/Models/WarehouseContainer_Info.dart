// To parse this JSON data, do
//
//     final warehouseInfo = warehouseInfoFromJson(jsonString);

import 'dart:convert';

WarehouseInfo warehouseInfoFromJson(String str) => WarehouseInfo.fromJson(json.decode(str));

String warehouseInfoToJson(WarehouseInfo data) => json.encode(data.toJson());

class WarehouseInfo {
  List<Datum> data;

  WarehouseInfo({
    required this.data,
  });

  factory WarehouseInfo.fromJson(Map<String, dynamic> json) => WarehouseInfo(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String containerNo;
  String size;
  String type;
  String shippingLineName;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.size,
    required this.type,
    required this.shippingLineName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
    size: json["Size"],
    type: json["Type"],
    shippingLineName: json["ShippingLineName"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "Size": size,
    "Type": type,
    "ShippingLineName": shippingLineName,
  };
}
