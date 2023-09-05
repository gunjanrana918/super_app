import 'dart:convert';
import 'package:http/http.dart'as http;
import '../universal.dart';

class Containerrake {
  bool error;
  String msg;
  String containerNo;

  Containerrake({
    required this.error,
    required this.msg,
    required this.containerNo,
  });

  factory Containerrake.fromJson(Map<String, dynamic> json) {
    return Containerrake(
        error: json["error"],
        msg: json["msg"] !,
        containerNo: json["ContainerNo"],
    );
  }
}


class ContainerViewModel {
 late  List<Containerrake> Data=[];
   int index=0;
  get i => null;
  Future<String?> loadPlayers() async {
    Data =  <Containerrake>[];
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = await http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ShowContainer'));
    request.body = json.encode({
      "Rake": Globaldata.Rakeno,
      "Location": Globaldata.Location,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    if(response.statusCode == 200){
      var parsedJson = json.decode(responseData);
      var categoryJson = parsedJson['Data'] as List;
      for (int i = 0; i < categoryJson.length; i++)
      {
        Data.add(Containerrake.fromJson(categoryJson[i]));
        print(Data);
        print('Global');
      }
    }
    else {
      throw Exception('Failed to load');
    }
    return null;
  }
}
