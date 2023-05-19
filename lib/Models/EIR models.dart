
class Eircopy {
  Eircopy({
    required this.eirCopy,
  });

  List<EirCopy> eirCopy;

  factory Eircopy.fromJson(Map<String, dynamic> json) => Eircopy(
    eirCopy: List<EirCopy>.from(json["EIRCopy"].map((x) => EirCopy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "EIRCopy": List<dynamic>.from(eirCopy.map((x) => x.toJson())),
  };
}

class EirCopy {
  EirCopy({
   required this.containerNo,
    required this.gateInDt,
    required this.filePath,
  });

  String containerNo;
  DateTime gateInDt;
  String filePath;

  factory EirCopy.fromJson(Map<String, dynamic> json) => EirCopy(
    containerNo: json["ContainerNo"],
    gateInDt: DateTime.parse(json["GateInDt"]),
    filePath: json["FilePath"],
  );

  Map<String, dynamic> toJson() => {
    "ContainerNo": containerNo,
    "GateInDt": "${gateInDt.year.toString().padLeft(4, '0')}-${gateInDt.month.toString().padLeft(2, '0')}-${gateInDt.day.toString().padLeft(2, '0')}",
    "FilePath": filePath,
  };
}
