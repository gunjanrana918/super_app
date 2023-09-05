// To parse this JSON data, do
//
//     final jobOrderdetails = jobOrderdetailsFromJson(jsonString);

import 'dart:convert';

JobOrderdetails jobOrderdetailsFromJson(String str) => JobOrderdetails.fromJson(json.decode(str));

String jobOrderdetailsToJson(JobOrderdetails data) => json.encode(data.toJson());

class JobOrderdetails {
  List<Datum> data;

  JobOrderdetails({
    required this.data,
  });

  factory JobOrderdetails.fromJson(Map<String, dynamic> json) => JobOrderdetails(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool error;
  String msg;
  List<Detail> details;

  Datum({
    required this.error,
    required this.msg,
    required this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    error: json["error"],
    msg: json["msg"],
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String containerNo;
  String examination;
  String weighmentRequired;
  String shiftingGroundingDone;
  String weighmentdone;

  Detail({
    required this.containerNo,
    required this.examination,
    required this.weighmentRequired,
    required this.shiftingGroundingDone,
    required this.weighmentdone,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    containerNo: json["ContainerNo"],
    examination: json["Examination"],
    weighmentRequired: json["WeighmentRequired"],
    shiftingGroundingDone: json["Shifting_Grounding_done"],
    weighmentdone: json["Weighmentdone"],
  );

  Map<String, dynamic> toJson() => {
    "ContainerNo": containerNo,
    "Examination": examination,
    "WeighmentRequired": weighmentRequired,
    "Shifting_Grounding_done": shiftingGroundingDone,
    "Weighmentdone": weighmentdone,
  };
}
