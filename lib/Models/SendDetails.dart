// To parse this JSON data, do
//
//     final sendcontainerdetails = sendcontainerdetailsFromJson(jsonString);

import 'dart:convert';

Sendcontainerdetails sendcontainerdetailsFromJson(String str) => Sendcontainerdetails.fromJson(json.decode(str));

String sendcontainerdetailsToJson(Sendcontainerdetails data) => json.encode(data.toJson());

class Sendcontainerdetails {
  List<Datum> data;

  Sendcontainerdetails({
    required this.data,
  });

  factory Sendcontainerdetails.fromJson(Map<String, dynamic> json) => Sendcontainerdetails(
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
  String fromLocation;
  String toLocation;
  String wagonno;
  String customSealNo;
  String lineSealNo;
  String surveyRemarks;
  String containerCondition;
  String customsSeal;
  String status;
  String lineSealStatus;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.size,
    required this.type,
    required this.fromLocation,
    required this.toLocation,
    required this.wagonno,
    required this.customSealNo,
    required this.lineSealNo,
    required this.surveyRemarks,
    required this.containerCondition,
    required this.customsSeal,
    required this.status,
    required this.lineSealStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
    size: json["Size"],
    type: json["Type"],
    fromLocation: json["FromLocation"],
    toLocation: json["ToLocation"],
    wagonno: json["Wagonno"],
    customSealNo: json["CustomSealNo"],
    lineSealNo: json["LineSealNo"],
    surveyRemarks: json["SurveyRemarks"],
    containerCondition: json["ContainerCondition"],
    customsSeal: json["CustomsSeal"],
    status: json["Status"],
    lineSealStatus: json["LineSealStatus"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "Size": size,
    "Type": type,
    "FromLocation": fromLocation,
    "ToLocation": toLocation,
    "Wagonno": wagonno,
    "CustomSealNo": customSealNo,
    "LineSealNo": lineSealNo,
    "SurveyRemarks": surveyRemarks,
    "ContainerCondition": containerCondition,
    "CustomsSeal": customsSeal,
    "Status": status,
    "LineSealStatus": lineSealStatus,
  };
}
