// To parse this JSON data, do
//
//     final foisRakeModel = foisRakeModelFromJson(jsonString);

import 'dart:convert';

FoisRakeModel foisRakeModelFromJson(String str) => FoisRakeModel.fromJson(json.decode(str));

String foisRakeModelToJson(FoisRakeModel data) => json.encode(data.toJson());

class FoisRakeModel {
  List<Datum> data;

  FoisRakeModel({
    required this.data,
  });

  factory FoisRakeModel.fromJson(Map<String, dynamic> json) => FoisRakeModel(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  String rakeid;
  String currentlocation;
  String foisrakeId;
  String datetime;
  String status;
  String fromlocation;
  String tolocation;
  String departureDateTime;
  String jnpt;
  String mdpt;
  String ppsp;
  String gdgh;
  String iagr;
  String pgfs;
  String ksp;

  Datum({
    required this.error,
    required this.msg,
    required this.rakeid,
    required this.currentlocation,
    required this.foisrakeId,
    required this.datetime,
    required this.status,
    required this.fromlocation,
    required this.tolocation,
    required this.departureDateTime,
    required this.jnpt,
    required this.mdpt,
    required this.ppsp,
    required this.gdgh,
    required this.iagr,
    required this.pgfs,
    required this.ksp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"]!,
    rakeid: json["rakeid"],
    currentlocation: json["currentlocation"],
    foisrakeId: json["foisrakeId"],
    datetime: json["datetime"],
    status: json["status"],
    fromlocation: json["fromlocation"],
    tolocation: json["Tolocation"],
    departureDateTime: json["DepartureDateTime"],
    jnpt: json["JNPT"],
    mdpt: json["MDPT"],
    ppsp: json["PPSP"],
    gdgh: json["GDGH"],
    iagr: json["IAGR"],
    pgfs: json["PGFS"],
    ksp: json["KSP"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "rakeid": rakeid,
    "currentlocation": currentlocation,
    "foisrakeId": foisrakeId,
    "datetime": datetime,
    "status": status,
    "fromlocation": fromlocation,
    "Tolocation": tolocation,
    "DepartureDateTime": departureDateTime,
    "JNPT": jnpt,
    "MDPT": mdpt,
    "PPSP": ppsp,
    "GDGH": gdgh,
    "IAGR": iagr,
    "PGFS": pgfs,
    "KSP": ksp,
  };
}


