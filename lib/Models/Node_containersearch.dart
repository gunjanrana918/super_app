

class AutoGenerate {
  AutoGenerate({
    required this.error,
    required this.msg,
    required this.ImportArrivalInfo,
  });
  late final bool error;
  late final String msg;
  late final List<ImportArrivalInformation> ImportArrivalInfo;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    error = json['error'];
    msg = json['msg'];
    ImportArrivalInfo = List.from(json['ImportArrivalInfo']).map((e)=>ImportArrivalInformation.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['msg'] = msg;
    _data['ImportArrivalInfo'] = ImportArrivalInfo.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ImportArrivalInformation {
  ImportArrivalInformation({
    required this.DocumentNo,
    required this.ContainerNo,
    required this.Size,
    required this.Type,
    required this.ArrivalDtTime,
    required this.FilePath,
  });
  late final String DocumentNo;
  late final String ContainerNo;
  late final String Size;
  late final String Type;
  late final String ArrivalDtTime;
  late final String FilePath;

  ImportArrivalInformation.fromJson(Map<String, dynamic> json){
    DocumentNo = json['DocumentNo'];
    ContainerNo = json['ContainerNo'];
    Size = json['Size'];
    Type = json['Type'];
    ArrivalDtTime = json['ArrivalDtTime'];
    FilePath = json['FilePath'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DocumentNo'] = DocumentNo;
    _data['ContainerNo'] = ContainerNo;
    _data['Size'] = Size;
    _data['Type'] = Type;
    _data['ArrivalDtTime'] = ArrivalDtTime;
    _data['FilePath'] = FilePath;
    return _data;
  }
}