// To parse this JSON data, do
//
//     final rakehistorydata = rakehistorydataFromJson(jsonString);

import 'dart:convert';

Rakehistorydata rakehistorydataFromJson(String str) => Rakehistorydata.fromJson(json.decode(str));

String rakehistorydataToJson(Rakehistorydata data) => json.encode(data.toJson());

class Rakehistorydata {
  List<Datum> data;

  Rakehistorydata({
    required this.data,
  });

  factory Rakehistorydata.fromJson(Map<String, dynamic> json) => Rakehistorydata(
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
  String customSealStatus;
  String lineSealStatus;
  String surveyWagonNo;
  String surveyCustomSealNo;
  String surveyLineSealNo;
  String surveyContainerCondition;

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
    required this.customSealStatus,
    required this.lineSealStatus,
    required this.surveyWagonNo,
    required this.surveyCustomSealNo,
    required this.surveyLineSealNo,
    required this.surveyContainerCondition,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"]!,
    containerNo: json["ContainerNo"],
    size: json["Size"],
    type: json["Type"]!,
    fromLocation: json["FromLocation"]!,
    toLocation:json["ToLocation"]!,
    wagonno: json["Wagonno"],
    customSealNo: json["CustomSealNo"],
    lineSealNo: json["LineSealNo"],
    customSealStatus: json["CustomSealStatus"]!,
    lineSealStatus:json["LineSealStatus"]!,
    surveyWagonNo: json["SurveyWagonNo"]!,
    surveyCustomSealNo: json["SurveyCustomSealNo"],
    surveyLineSealNo: json["SurveyLineSealNo"],
    surveyContainerCondition: json["SurveyContainerCondition"]!,
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
    "CustomSealStatus": customSealStatus,
    "LineSealStatus": lineSealStatus,
    "SurveyWagonNo": surveyWagonNo,
    "SurveyCustomSealNo": surveyCustomSealNo,
    "SurveyLineSealNo": surveyLineSealNo,
    "SurveyContainerCondition": surveyContainerCondition,
  };
}



