import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/responseapi.dart';
import 'app_constant.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();

  factory ApiManager() => _instance;

  ApiManager._internal();

  static final Dio _dio = Dio();

  static logMessage(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  static Future<ResponseAPI> post({required String methodName, required Map<String, dynamic> params}) async {
    try {
      ResponseAPI? interNetMap = await _checkConnectivity();
      if (interNetMap != null) {
        return interNetMap;
      }
      String url = ApiConstant.baseUrl + methodName;
      Options options = Options(
        headers: {"Content-Type": "application/json"},
      );
      logMessage("==request== $url");
      logMessage("==params== $params");
      Response response = await _dio.post(url, data: params, options: options);
      logMessage("==response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      logMessage("==error==$error");
      return _handleError(error);
    }
  }

  static Future<ResponseAPI> get({required String methodName, required String bearerToken, required String privateKey}) async {
    try {
      ResponseAPI? interNetMap = await _checkConnectivity();
      if (interNetMap != null) {
        return interNetMap;
      }
      String url = ApiConstant.baseUrl + methodName;
      Options options = Options(
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $bearerToken", "key": privateKey},
      );
      logMessage("==request== $url");
      Response response = await _dio.get(url, options: options);
      logMessage("==response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      return _handleError(error);
    }
  }

  static Future<ResponseAPI> mapGetAPI({required String url}) async {
    try {
      await _checkConnectivity();
      logMessage("==MAP API request== $url");
      Response response = await _dio.get(
        url,
      );
      logMessage("==MAP API response== ${response.data}");
      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      logMessage("==error==$error");
      return _handleError(error);
    }
  }

  static Future<ResponseAPI?> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
      // throw ApiError(1, "No internet");
      return ResponseAPI(1, {"Message": "No internet"}, isError: true, error: jsonEncode({"Message": "No internet"}));
    }
    return null;
  }

  static ResponseAPI _handleError(dynamic error) {
    logMessage("Error== $error");
    return ResponseAPI(0, {"error": error}, isError: true, error: error);
  }
}
