import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:siarashield_flutter/constants/app_constant.dart';
import 'package:siarashield_flutter/constants/dio_service.dart';
import 'package:siarashield_flutter/constants/shared_prefrence_storage.dart';

import '../common/common_widgets.dart';
import '../models/get_info_model.dart';
import '../models/responseapi.dart';
import '../siarashield_flutter.dart';

class SaraShieldController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isOtherLoading = false.obs;
  RxString error = "".obs;
  RxString apiError = "".obs;

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final IpAddress _ipAddress = IpAddress();
  RxString requestId = "".obs;
  RxString visiterId = "".obs;
  String deviceName = "";
  String deviceIp = "";
  String udid = "";
  RxBool isVerified = false.obs;

  getMyDeviceInfo(double height, double width, CyberCieraModel cieraModel) async {
    isLoading(true);
    error("");
    apiError("");
    requestId("");
    visiterId("");
    removeToken();
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
      };

      ResponseAPI responseAPI = await ApiManager.post(methodName: ApiConstant.getCyberSiaraForAndroid, params: map);
      Map<String, dynamic> valueMap = (responseAPI.response);
      if (valueMap["Message"] == "success") {
        GetInfoModel getInfoModel = GetInfoModel.fromJson(valueMap);
        requestId.value = getInfoModel.requestId;
        visiterId.value = getInfoModel.visiterId;
      } else {
        apiError(valueMap["Message"]);
        toast(apiError.value.toString());
      }
    } catch (err) {
      error(err.toString());
      toast(err.toString());
    } finally {
      isLoading(false);
    }
  }

  slideButton(context, CyberCieraModel cieraModel) async {
    isVerified(false);
    isOtherLoading(true);
    error("");
    apiError("");
    Map<String, dynamic> map = {
      "MasterUrl": cieraModel.masterUrlId,
      "BrowserIdentity": udid,
      "DeviceIp": deviceIp,
      "DeviceName": deviceName,
      // "DeviceType": Platform.isAndroid ? "Android" : "ios",
      // "DeviceBrowser": 'Chrome',
      "Protocol": "http",
      "second": "5",
      "RequestID": requestId.value,
      "VisiterId": visiterId.value
    };
    try {
      ResponseAPI responseAPI = await ApiManager.post(methodName: ApiConstant.verifiedSubmitForAndroid, params: map);
      Map<String, dynamic> valueMap = responseAPI.response;
      if (valueMap["Message"] == "success") {
        bool success = await validateToken(valueMap["data"], cieraModel);
        if (success) {
          isVerified(true);
        } else {
          error("We cannot verify your key.");
          isVerified(false);
        }
      } else if (valueMap["Message"] == "fail") {
        isVerified(false);
      } else {
        apiError(valueMap["Message"]);
        toast(apiError.value.toString());
      }
    } catch (err) {
      apiError(err.toString());
    } finally {
      isOtherLoading(false);
    }
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
