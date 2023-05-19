// To parse this JSON data, do
//
//     final otpValidation = otpValidationFromJson(jsonString);

import 'dart:convert';

OtpValidation otpValidationFromJson(String str) => OtpValidation.fromJson(json.decode(str));

String otpValidationToJson(OtpValidation data) => json.encode(data.toJson());

class OtpValidation {
  List<Login> login;

  OtpValidation({
    required this.login,
  });

  factory OtpValidation.fromJson(Map<String, dynamic> json) => OtpValidation(
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
  dynamic password;

  Login({
    required this.error,
    required this.msg,
    required this.userId,
    this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    error: json["error"],
    msg: json["msg"],
    userId: json["UserId"],
    password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "UserId": userId,
    "Password": password,
  };
}
