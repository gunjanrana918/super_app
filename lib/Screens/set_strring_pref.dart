import 'package:shared_preferences/shared_preferences.dart';

Future<void> setStringInPref({required String key, required String value}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(key, value).then((value) {
    print("String Stored");
  });
}
Future<void> setBoolInPref({required String key, required bool value}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool(key, value).then((value) {
  });
}