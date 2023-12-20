import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class Players {
  bool error;
  String msg;
  String containerNo;
  String arrivalDate;
  String location;

  Players({
    required this.error,
    required this.msg,
    required this.containerNo,
    required this.arrivalDate,
    required this.location,
  });

  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
        error: json["error"],
        msg: json["msg"] !,
        containerNo: json["ContainerNo"],
        arrivalDate: json["ArrivalDate"],
        location: json["Location"]!
    );
  }
}


class PlayersViewModel {
    List<Players> Data=[];
  get i => null;
  //destuffing//
  Future<String?> loadPlayers() async {
      Data =  <Players>[];
      var headers = {
        'Content-Type': 'application/json'
      };
      var request =  http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/api/GetContainer'));
      request.body = json.encode({
        "Location": Globaldata.Location,
        "Rtype":"0",
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      if(response.statusCode == 200){
        Map parsedJson = json.decode(responseData);
        var categoryJson = parsedJson['Data'] as List;
        for (int i = 0; i < categoryJson.length; i++) {
          Data.add( Players.fromJson(categoryJson[i]));

      }
      }
      else {
        throw Exception('Failed to load');
      }
    return null;
  }
  //stuffing//

}
