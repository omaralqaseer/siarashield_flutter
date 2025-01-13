import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import '../common/common_widgets.dart';
import '../models/responseapi.dart';
import 'app_constant.dart';

postAPI({required String methodName, required Map<String, dynamic> param, required Function(ResponseAPI) callback}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
    String url = ApiConstant.baseUrl + methodName;
    Uri uri = Uri.parse(url);
    log("==request== $uri");
    log("==params== $param");
    // log("==token== ${AppConstants.authToken}");
    await http.post(uri, headers: {"Content-Type": "application/json"}, body: json.encode(param)).then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      log("onError== $error");
      throw _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } else {
    toast("No Internet");
    callback.call(ResponseAPI(
      0,
      "No Internet",
      isError: true,
    ));
  }
}

_handleResponse(http.Response value, Function(ResponseAPI) callback) {
  log("==response== ${value.body}");
  callback.call(ResponseAPI(value.statusCode, value.body));
}

_handleError(value, Function(ResponseAPI) callback) {
  log("error:::::::::::::: ${value.body}");
  callback.call(ResponseAPI(
    0,
    "Something went wrong",
    isError: true,
    error: value,
  ));
}
