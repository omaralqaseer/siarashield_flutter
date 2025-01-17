import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../models/responseapi.dart';
import 'app_constant.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();

  factory ApiManager() => _instance;

  ApiManager._internal();

  static final Dio _dio = Dio();

  static Future<ResponseAPI> post({required String methodName, required Map<String, dynamic> params}) async {
    try {
      await _checkConnectivity();
      String url = ApiConstant.baseUrl + methodName;
      Options options = Options(
        headers: {"Content-Type": "application/json"},
      );
      log("==request== $url");
      log("==params== $params");

      Response response = await _dio.post(url, data: params, options: options);
      log("==response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      log("==error==$error");
      return _handleError(error);
    }
  }

  static Future<ResponseAPI> get({required String methodName, required String bearerToken, required String privateKey}) async {
    try {
      await _checkConnectivity();
      String url = ApiConstant.baseUrl + methodName;
      Options options = Options(
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $bearerToken", "key": privateKey},
      );
      log("==request== $url");
      Response response = await _dio.get(url, options: options);
      log("==response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      return _handleError(error);
    }
  }

  static Future<ResponseAPI> mapGetAPI({required String url}) async {
    try {
      await _checkConnectivity();
      log("==MAP API request== $url");
      Response response = await _dio.get(
        url,
      );
      log("==MAP API response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      log("==error==$error");
      return _handleError(error);
    }
  }

  static Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) && connectivityResult.contains(ConnectivityResult.wifi)) {
      // throw ApiError(1, "No internet");
      throw ResponseAPI(1, {"error": "No internet"}, isError: true, error: jsonEncode({"error": "No internet"}));
    }
  }

  static ResponseAPI _handleError(dynamic error) {
    log("Error== $error");
    return ResponseAPI(0, {"error": error}, isError: true, error: error);
  }
}
