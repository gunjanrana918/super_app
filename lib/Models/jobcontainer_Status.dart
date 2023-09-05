// To parse this JSON data, do
//
//     final jobContainerstatus = jobContainerstatusFromJson(jsonString);

import 'dart:convert';

JobContainerstatus jobContainerstatusFromJson(String str) => JobContainerstatus.fromJson(json.decode(str));

String jobContainerstatusToJson(JobContainerstatus data) => json.encode(data.toJson());

class JobContainerstatus {
  List<Datum> data;

  JobContainerstatus({
    required this.data,
  });

  factory JobContainerstatus.fromJson(Map<String, dynamic> json) => JobContainerstatus(
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
  String examination;
  String weighmentRequired;
  String shiftingGroundingDone;
  String weighmentdone;

  Datum({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.examination,
    required this.weighmentRequired,
    required this.shiftingGroundingDone,
    required this.weighmentdone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    containerNo: json["ContainerNo"],
    examination: json["Examination"],
    weighmentRequired: json["WeighmentRequired"],
    shiftingGroundingDone: json["Shifting_Grounding_done"],
    weighmentdone: json["Weighmentdone"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "ContainerNo": containerNo,
    "Examination": examination,
    "WeighmentRequired": weighmentRequired,
    "Shifting_Grounding_done": shiftingGroundingDone,
    "Weighmentdone": weighmentdone,
  };
}
