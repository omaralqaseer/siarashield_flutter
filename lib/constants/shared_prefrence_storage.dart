import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A utility class to manage token storage using SharedPreferences.
class SharedPrefrenceStorage {
  /// Key used to store the authentication token in SharedPreferences.
  static const String token = 'token';
}

/// Stores the given token data in SharedPreferences.
///
/// The data is stored as a JSON-encoded string.
///
/// [map] - A map containing the token and its associated metadata.
Future<void> setToken(Map<String, dynamic> map) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  var data = json.encode(map); // Convert the map to a JSON string.
  sp.setString(SharedPrefrenceStorage.token, data); // Save the token.
}

/// Retrieves the stored token from SharedPreferences.
///
/// Returns a `Map<String, dynamic>?` containing the token data if available,
/// or `null` if no token is stored.
Future<Map<String, dynamic>?> getToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? data = sp.getString(SharedPrefrenceStorage.token); // Get stored token.
  Map<String, dynamic> map = {};

  if (data != null) {
    map = json.decode(data); // Decode the JSON string back into a map.
  }

  return map;
}

/// Removes the stored authentication token from SharedPreferences.
Future<void> removeToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.remove(SharedPrefrenceStorage.token); // Delete the stored token.
}
