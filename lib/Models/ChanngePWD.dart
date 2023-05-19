// To parse this JSON data, do
//
//     final changepassword = changepasswordFromJson(jsonString);

import 'dart:convert';

Changepassword changepasswordFromJson(String str) => Changepassword.fromJson(json.decode(str));

String changepasswordToJson(Changepassword data) => json.encode(data.toJson());

class Changepassword {
  List<Resetpwd> resetpwd;

  Changepassword({
    required this.resetpwd,
  });

  factory Changepassword.fromJson(Map<String, dynamic> json) => Changepassword(
    resetpwd: List<Resetpwd>.from(json["Resetpwd"].map((x) => Resetpwd.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Resetpwd": List<dynamic>.from(resetpwd.map((x) => x.toJson())),
  };
}

class Resetpwd {
  bool error;
  String msg;

  Resetpwd({
    required this.error,
    required this.msg,
  });

  factory Resetpwd.fromJson(Map<String, dynamic> json) => Resetpwd(
    error: json["error"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
  };
}
