import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class stuffing {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;
  String location;

  stuffing({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
    required this.location,
  });

  factory stuffing.fromJson(Map<String, dynamic> json) {
    return stuffing(
        error: json["error"],
        msg: json["msg"] !,
        containerNo: json["ContainerNo"],
        arrivalDate: json["ArrivalDate"],
        location: json["Location"]!
    );
  }
}


class StuffingViewModel {
  List<stuffing> Data=[];
  get i => null;
  //destuffing//
  Future<String?> loadstuffing() async {
    Data =  <stuffing>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request =  http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/GetContainer'));
    request.body = json.encode({
      "Location": Globaldata.Location,
      "Rtype":"1",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      Map parsedJson = json.decode(responseData);
      var categoryJson = parsedJson['Data'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        Data.add( stuffing.fromJson(categoryJson[i]));

      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
//stuffing//

}
