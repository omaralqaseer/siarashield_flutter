import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceStorage {
  static const String token = 'token';
}

setToken(Map<String, dynamic> map) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  var data = json.encode(map);
  sp.setString(SharedPrefrenceStorage.token, data);
}

Future<Map<String, dynamic>?> getToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? data = sp.getString(SharedPrefrenceStorage.token);
  Map<String, dynamic> map = {};
  if (data != null) {
    map = json.decode(data);
  }
  return map;
}

removeToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.remove(SharedPrefrenceStorage.token);
}
