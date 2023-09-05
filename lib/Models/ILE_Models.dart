// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Datum> data;

  Welcome({
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String containerNo;
  String activityType;
  List<FilePath> filePath;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.activityType,
    required this.filePath,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
    activityType: json["ActivityType"],
    filePath: List<FilePath>.from(json["FilePath"].map((x) => FilePath.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "ActivityType": activityType,
    "FilePath": List<dynamic>.from(filePath.map((x) => x.toJson())),
  };
}

class FilePath {
  String filename;
  String dtTime;
  String time;
  String remarks;

  FilePath({
    required this.filename,
    required this.dtTime,
    required this.time,
    required this.remarks,
  });

  factory FilePath.fromJson(Map<String, dynamic> json) => FilePath(
    filename: json["Filename"],
    dtTime: json["DtTime"],
    time: json["Time"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "Filename": filename,
    "DtTime": dtTime,
    "Time": time,
    "Remarks": remarks,
  };
}
