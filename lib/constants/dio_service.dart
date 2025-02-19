import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/response_api.dart';
import 'app_constant.dart';

/// A singleton class for managing API requests using Dio.
class ApiManager {
  /// The single instance of [ApiManager].
  static final ApiManager _instance = ApiManager._internal();

  /// Factory constructor that returns the single instance of [ApiManager].
  factory ApiManager() => _instance;

  /// Private named constructor for creating the singleton instance.
  ApiManager._internal();

  /// Dio instance used for making HTTP requests.
  static final Dio _dio = Dio();

  /// Logs messages only in debug mode.
  static logMessage(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  /// Sends a `POST` request to the given [methodName] with the provided [params].
  ///
  /// - Checks internet connectivity before making the request.
  /// - Logs request details for debugging.
  /// - Returns a [ResponseAPI] object containing the response data.
  ///
  /// If an error occurs, it is handled and returned as an error response.
  static Future<ResponseAPI> post({
    required String methodName,
    required Map<String, dynamic> params,
  }) async {
    try {
      ResponseAPI? interNetMap = await _checkConnectivity();
      if (interNetMap != null) {
        return interNetMap; // Return error response if no internet connection.
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
      return _handleError(error); // Handle and return error response.
    }
  }

  /// Sends a `GET` request to the given [methodName] with authentication headers.
  ///
  /// - Uses [bearerToken] for authorization and [privateKey] for additional security.
  /// - Logs the request and response for debugging.
  /// - Returns a [ResponseAPI] object containing the response data.
  ///
  /// If an error occurs, it is handled and returned as an error response.
  static Future<ResponseAPI> get({
    required String methodName,
    required String bearerToken,
    required String privateKey,
  }) async {
    try {
      ResponseAPI? interNetMap = await _checkConnectivity();
      if (interNetMap != null) {
        return interNetMap; // Return error response if no internet connection.
      }

      String url = ApiConstant.baseUrl + methodName;
      Options options = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $bearerToken",
          "key": privateKey,
        },
      );

      logMessage("==request== $url");

      Response response = await _dio.get(url, options: options);

      logMessage("==response== ${response.data}");

      return ResponseAPI(response.statusCode ?? 0, response.data);
    } catch (error) {
      return _handleError(error); // Handle and return error response.
    }
  }

  /// Checks internet connectivity before making an API request.
  ///
  /// - If no internet connection is detected, it returns an error response.
  /// - Otherwise, returns `null`, indicating internet is available.
  static Future<ResponseAPI?> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
      // Return an error response indicating no internet.
      return ResponseAPI(1, {"Message": "No internet"}, isError: true, error: jsonEncode({"Message": "No internet"}));
    }
    return null; // Internet is available.
  }

  /// Handles API errors and returns a standardized [ResponseAPI] object.
  ///
  /// - Logs the error message.
  /// - Returns a response with an error flag set to `true`.
  static ResponseAPI _handleError(dynamic error) {
    logMessage("Error== $error");
    return ResponseAPI(0, {"error": error}, isError: true, error: error);
  }
}
