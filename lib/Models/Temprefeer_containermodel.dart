import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class Temprefer {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;
  String location;

  Temprefer({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
    required this.location,
  });

  factory Temprefer.fromJson(Map<String, dynamic> json) {
    return Temprefer(
        error: json["error"],
        msg: json["msg"] !,
        containerNo: json["ContainerNo"],
        arrivalDate: json["ArrivalDate"],
        location: json["Location"]!
    );
  }
}


class TempViewModel {
  // List Data=[];
  late List<Temprefer> Data;

  get i => null;
  Future<String?> loadreffercontainer() async {
    Data =  <Temprefer>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/GetContainerReefer'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var categoryJson = parsedJson['Data'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        Data.add( Temprefer.fromJson(categoryJson[i]));
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}
