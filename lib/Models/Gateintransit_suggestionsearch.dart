import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class Gateintransit {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;
  String location;

  Gateintransit({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
    required this.location,
  });

  factory Gateintransit.fromJson(Map<String, dynamic> json) {
    return Gateintransit(
        error: json["error"],
        msg: json["msg"] !,
        containerNo: json["ContainerNo"],
        arrivalDate: json["ArrivalDate"],
        location: json["Location"]!
    );
  }
}


class IntransitViewModel {
  // List Data=[];
  late List<Gateintransit> Data;

  get i => null;
  Future<String?> loadtransitdata() async {
    Data =  <Gateintransit>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/GetIntransit'));
    request.body = json.encode({
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var transitdata = parsedJson['Data'] as List;
      for (int i = 0; i < transitdata.length; i++) {
        Data.add(new Gateintransit.fromJson(transitdata[i]));
        print(Data);
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}
