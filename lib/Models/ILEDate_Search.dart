// To parse this JSON data, do
//
//     final dateIleSearch = dateIleSearchFromJson(jsonString);

import 'dart:convert';

DateIleSearch dateIleSearchFromJson(String str) => DateIleSearch.fromJson(json.decode(str));

String dateIleSearchToJson(DateIleSearch data) => json.encode(data.toJson());

class DateIleSearch {
  List<Datum> data;

  DateIleSearch({
    required this.data,
  });

  factory DateIleSearch.fromJson(Map<String, dynamic> json) => DateIleSearch(
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
  String dtTime;
  List<FilePath> filePath;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.activityType,
    required this.dtTime,
    required this.filePath,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"]!,
    containerNo: json["ContainerNo"],
    activityType: json["ActivityType"]!,
    dtTime: json["DtTime"]!,
    filePath: List<FilePath>.from(json["FilePath"].map((x) => FilePath.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "ActivityType": activityType,
    "DtTime": dtTime,
    "FilePath": List<dynamic>.from(filePath.map((x) => x.toJson())),
  };
}





class FilePath {
  String filename;
  String time;
  String remarks;

  FilePath({
    required this.filename,
    required this.time,
    required this.remarks,
  });

  factory FilePath.fromJson(Map<String, dynamic> json) => FilePath(
    filename: json["Filename"],
    time: json["Time"]!,
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "Filename": filename,
    "Time": time,
    "Remarks": remarks,
  };
}



