// To parse this JSON data, do
//
//     final rakelistinfo = rakelistinfoFromJson(jsonString);

import 'dart:convert';

Rakelistinfo rakelistinfoFromJson(String str) => Rakelistinfo.fromJson(json.decode(str));

String rakelistinfoToJson(Rakelistinfo data) => json.encode(data.toJson());

class Rakelistinfo {
  List<Datum> data;

  Rakelistinfo({
    required this.data,
  });

  factory Rakelistinfo.fromJson(Map<String, dynamic> json) => Rakelistinfo(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String rake;
  String location;
  String countWagonnNo;
  String count20;
  String count40;
  String totalTues;
  String completeCount20;
  String completeCount40;
  String pendingCount20;
  String pendingCount40;
  String countGhh20;
  String countGhh40;
  String countSnl20;
  String countSnl40;
  String countPyl20;
  String countPyl40;
  String countKsp20;
  String countKsp40;
  String countGrfv20;
  String countGrfv40;

  Datum({
    required this.error,
    required this.msg,
    required this.rake,
    required this.location,
    required this.countWagonnNo,
    required this.count20,
    required this.count40,
    required this.totalTues,
    required this.completeCount20,
    required this.completeCount40,
    required this.pendingCount20,
    required this.pendingCount40,
    required this.countGhh20,
    required this.countGhh40,
    required this.countSnl20,
    required this.countSnl40,
    required this.countPyl20,
    required this.countPyl40,
    required this.countKsp20,
    required this.countKsp40,
    required this.countGrfv20,
    required this.countGrfv40,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    rake: json["rake"],
    location: json["Location"],
    countWagonnNo: json["CountWagonnNo"],
    count20: json["Count20"],
    count40: json["Count40"],
    totalTues: json["TotalTues"],
    completeCount20: json["CompleteCount20"],
    completeCount40: json["CompleteCount40"],
    pendingCount20: json["PendingCount20"],
    pendingCount40: json["PendingCount40"],
    countGhh20: json["CountGHH20"],
    countGhh40: json["CountGHH40"],
    countSnl20: json["CountSNL20"],
    countSnl40: json["CountSNL40"],
    countPyl20: json["CountPYL20"],
    countPyl40: json["CountPYL40"],
    countKsp20: json["CountKSP20"],
    countKsp40: json["CountKSP40"],
    countGrfv20: json["CountGRFV20"],
    countGrfv40: json["CountGRFV40"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "rake": rake,
    "Location": location,
    "CountWagonnNo": countWagonnNo,
    "Count20": count20,
    "Count40": count40,
    "TotalTues": totalTues,
    "CompleteCount20": completeCount20,
    "CompleteCount40": completeCount40,
    "PendingCount20": pendingCount20,
    "PendingCount40": pendingCount40,
    "CountGHH20": countGhh20,
    "CountGHH40": countGhh40,
    "CountSNL20": countSnl20,
    "CountSNL40": countSnl40,
    "CountPYL20": countPyl20,
    "CountPYL40": countPyl40,
    "CountKSP20": countKsp20,
    "CountKSP40": countKsp40,
    "CountGRFV20": countGrfv20,
    "CountGRFV40": countGrfv40,
  };
}
