// To parse this JSON data, do
//
//     final joDatadetails = joDatadetailsFromJson(jsonString);

import 'dart:convert';

JoDatadetails joDatadetailsFromJson(String str) => JoDatadetails.fromJson(json.decode(str));

String joDatadetailsToJson(JoDatadetails data) => json.encode(data.toJson());

class JoDatadetails {
  List<Datum> data;

  JoDatadetails({
    required this.data,
  });

  factory JoDatadetails.fromJson(Map<String, dynamic> json) => JoDatadetails(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String documentno;
  String location;
  String date;
  String igmno;
  String igmDate;
  String igmLineno;
  String boeno;
  String boeDate;
  String consigneeName;
  String examination;
  String weighmentRequired;

  Datum({
    required this.error,
    required this.msg,
    required this.documentno,
    required this.location,
    required this.date,
    required this.igmno,
    required this.igmDate,
    required this.igmLineno,
    required this.boeno,
    required this.boeDate,
    required this.consigneeName,
    required this.examination,
    required this.weighmentRequired,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    documentno: json["Documentno"],
    location: json["Location"],
    date: json["Date"],
    igmno: json["Igmno"],
    igmDate: json["IgmDate"],
    igmLineno: json["IgmLineno"],
    boeno: json["Boeno"],
    boeDate: json["BoeDate"],
    consigneeName: json["ConsigneeName"],
    examination: json["Examination"],
    weighmentRequired: json["WeighmentRequired"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "Documentno": documentno,
    "Location": location,
    "Date": date,
    "Igmno": igmno,
    "IgmDate": igmDate,
    "IgmLineno": igmLineno,
    "Boeno": boeno,
    "BoeDate": boeDate,
    "ConsigneeName": consigneeName,
    "Examination": examination,
    "WeighmentRequired": weighmentRequired,
  };
}
