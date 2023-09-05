// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class User {
//   bool error;
//   String msg;
//   String containerNo;
//
//   User({
//     required this.error,
//     required this.msg,
//     required this.containerNo,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       error: json["error"],
//       msg: json["msg"] !,
//       containerNo: json["ContainerNo"],
//     );
//   }
// }
//
// class UserApi {
//    Future<List<User>> getUserSuggestions( query) async {
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('GET', Uri.parse('http://103.25.130.254/grfl_login_api/Api/ShowContainer'));
//     request.body = json.encode({
//       "Rake": "gr-11",
//       "Location": "ghh"
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final List users = json.decode(response);
//       return users.map((json) => User.fromJson(json)).where((user) {
//         final nameLower = user.containerNo.toLowerCase();
//         final queryLower = query.toLowerCase();
//
//         return nameLower.contains(queryLower);
//       }).toList();
//     } else {
//       throw Exception();
//     }
//   }
// }