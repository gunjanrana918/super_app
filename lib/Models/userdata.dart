// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Login> login;

  Welcome({
    required this.login,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    login: List<Login>.from(json["Login"].map((x) => Login.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Login": List<dynamic>.from(login.map((x) => x.toJson())),
  };
}

class Login {
  bool error;
  String msg;
  String userId;
  String password;
  String location;

  Login({
    required this.error,
    required this.msg,
    required this.userId,
    required this.password,
    required this.location,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    error: json["error"],
    msg: json["msg"],
    userId: json["UserId"],
    password: json["Password"],
    location: json["Location"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "UserId": userId,
    "Password": password,
    "Location": location,
  };
}
