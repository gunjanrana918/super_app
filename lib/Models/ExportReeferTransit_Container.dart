import 'dart:convert';
import 'package:http/http.dart'as http;

class Exportrefertransit {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;
  String location;

  Exportrefertransit({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
    required this.location,
  });

  factory Exportrefertransit.fromJson(Map<String, dynamic> json) {
    return Exportrefertransit(
        error: json["error"],
        msg: json["msg"]!,
        containerNo: json["ContainerNo"],
        arrivalDate: json["ArrivalDate"],
        location: json["Location"]!
    );
  }
}


class ExportreeferViewModel {
  // List Data=[];
  late List<Exportrefertransit> exportData;

  get i => null;
  Future<String?> loadrexporteffercontainer() async {
    exportData =  <Exportrefertransit>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/GetIntransitReefer'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var categoryJson = parsedJson['Data'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        exportData.add( Exportrefertransit.fromJson(categoryJson[i]));
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}
