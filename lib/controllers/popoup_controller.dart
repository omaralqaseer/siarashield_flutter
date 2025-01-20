import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:siarashield_flutter/constants/app_constant.dart';
import 'package:siarashield_flutter/constants/dio_service.dart';

import '../common/common_widgets.dart';
import '../models/responseapi.dart';
import '../siarashield_flutter.dart';

class PopupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isOtherLoading = false.obs;
  RxString error = "".obs;

  RxString requestId = "".obs;
  RxString visiterId = "".obs;
  String deviceName = "";
  String deviceIp = "";
  String udid = "";
  RxBool isVerified = false.obs;

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final IpAddress _ipAddress = IpAddress();

  RxString captchaUrl = "".obs;

  getCaptcha({required double height, required double width, required String visiterId, required CyberCieraModel cieraModel}) async {
    isOtherLoading(true);
    error("");
    captchaUrl("");
    try {
      deviceName = "";
      deviceIp = await _ipAddress.getIp();
      udid = await FlutterUdid.udid;

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.brand;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.model;
      }
      Map<String, dynamic> map = {
        "MasterUrlId": cieraModel.masterUrlId, // "VYz433DfqQ5LhBcgaamnbw4Wy4K9CyQT",
        "RequestUrl": cieraModel.requestUrl, // "com.app.cyber_ceiara",
        "BrowserIdentity": udid,
        "DeviceIp": deviceIp,
        "DeviceType": Platform.isAndroid ? "Android" : "ios",
        "DeviceBrowser": 'Chrome',
        "DeviceName": deviceName,
        "DeviceHeight": height.round(),
        "DeviceWidth": width.round(),
        "VisiterId": visiterId,
      };
      ResponseAPI responseAPI = await ApiManager.post(methodName: ApiConstant.captchaForAndroid, params: map);
      Map<String, dynamic> valueMap = responseAPI.response;
      if (valueMap["Message"] == "success") {
        captchaUrl(valueMap["HtmlFormate"]);
      } else {
        toast("Api Error");
      }
    } catch (err) {
      error(err.toString());
      toast(error.value);
    } finally {
      isOtherLoading(false);
    }
  }

  Future<bool> submitCaptcha({required String txt, required String requestId, required String visiterId, required CyberCieraModel cieraModel}) async {
    isLoading(true);
    error("");
    bool isSuccess = false;
    try {
      Map<String, dynamic> map = {
        "MasterUrl": cieraModel.masterUrlId,
        "DeviceIp": deviceIp,
        "DeviceType": Platform.isAndroid ? "Android" : "ios",
        "DeviceName": deviceName,
        "UserCaptcha": txt,
        "ByPass": "Netural",
        "BrowserIdentity": udid,
        "Timespent": "24",
        "Protocol": "http",
        "Flag": "1",
        "second": "2",
        "RequestID": requestId,
        "VisiterId": visiterId,
        "fillupsecond": "8"
      };
      ResponseAPI responseAPI = await ApiManager.post(methodName: ApiConstant.submitCaptchInfoForAndroid, params: map);
      Map<String, dynamic> valueMap = (responseAPI.response);
      if (valueMap["Message"] == "success") {
        bool success = await validateToken(valueMap["data"], cieraModel);
        if (success) {
          isSuccess = success;
        } else {
          error("We cannot verify your private key.");
        }
      } else {
        error("You have enter wrong code");
      }
    } catch (err) {
      error(err.toString());
    } finally {
      isLoading(false);
    }
    return isSuccess;
  }

  Future<bool> validateToken(String bearerToken, CyberCieraModel cieraModel) async {
    bool isSuccess = false;
    try {
      ResponseAPI responseAPI =
          await ApiManager.get(methodName: ApiConstant.validateToken, privateKey: cieraModel.privateKey, bearerToken: bearerToken);
      Map<String, dynamic> valueMap = responseAPI.response;
      if (valueMap["Message"] == "Verified") {
        isSuccess = true;
      }
    } catch (err) {
      error(err.toString());
    }
    return isSuccess;
  }
}
