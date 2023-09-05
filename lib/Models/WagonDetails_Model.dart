// To parse this JSON data, do
//
//     final wagomDetails = wagomDetailsFromJson(jsonString);

import 'dart:convert';

WagomDetails wagomDetailsFromJson(String str) => WagomDetails.fromJson(json.decode(str));

String wagomDetailsToJson(WagomDetails data) => json.encode(data.toJson());

class WagomDetails {
  List<Datum> data;

  WagomDetails({
    required this.data,
  });

  factory WagomDetails.fromJson(Map<String, dynamic> json) => WagomDetails(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String departuredate;
  String wagonno;
  List<Detail> details;

  Datum({
    required this.error,
    required this.msg,
    required this.departuredate,
    required this.wagonno,
    required this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    departuredate: json["Departuredate"],
    wagonno: json["Wagonno"],
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "Departuredate": departuredate,
    "Wagonno": wagonno,
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String containerNo;
  String size;
  String type;
  String fromLocation;
  String toLocation;
  String documentno;
  String status;

  Detail({
    required this.containerNo,
    required this.size,
    required this.type,
    required this.fromLocation,
    required this.toLocation,
    required this.documentno,
    required this.status,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    containerNo: json["ContainerNo"],
    size: json["Size"],
    type: json["Type"],
    fromLocation: json["FromLocation"],
    toLocation: json["ToLocation"],
    documentno: json["Documentno"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "ContainerNo": containerNo,
    "Size": size,
    "Type": type,
    "FromLocation": fromLocation,
    "ToLocation": toLocation,
    "Documentno": documentno,
    "Status": status,
  };
}
