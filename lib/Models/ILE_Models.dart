// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool error;
  String msg;
  List<Datum> data;

  Welcome({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    error: json["error"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String containerNo;
  String activityType;
  String dtTime;
  String remarks;
  List<FilePath> filePath;

  Datum({
    required this.containerNo,
    required this.activityType,
    required this.dtTime,
    required this.remarks,
    required this.filePath,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    containerNo: json["ContainerNo"],
    activityType: json["ActivityType"],
    dtTime: json["DtTime"],
    remarks: json["Remarks"],
    filePath: List<FilePath>.from(json["FilePath"].map((x) => FilePath.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ContainerNo": containerNo,
    "ActivityType": activityType,
    "DtTime": dtTime,
    "Remarks": remarks,
    "FilePath": List<dynamic>.from(filePath.map((x) => x.toJson())),
  };
}

class FilePath {
  String filename;

  FilePath({
    required this.filename,
  });

  factory FilePath.fromJson(Map<String, dynamic> json) => FilePath(
    filename: json["Filename"],
  );

  Map<String, dynamic> toJson() => {
    "Filename": filename,
  };
}
