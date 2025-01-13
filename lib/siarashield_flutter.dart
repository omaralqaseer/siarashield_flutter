import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siarashield_flutter/common/extension_widget.dart';
import 'package:siarashield_flutter/popup_screen.dart';

import 'application_constants/app_constant.dart';
import 'common/common_widgets.dart';
import 'controllers/sara_shield_controller.dart';

class CyberCieraModel {
  late final String masterUrlId;
  late final String requestUrl;

  CyberCieraModel({required this.masterUrlId, required this.requestUrl});
}

class SaraShieldWidget extends StatefulWidget {
  final CyberCieraModel cieraModel;
  final Function(bool isTrue) loginTap;

  const SaraShieldWidget({super.key, required this.cieraModel, required this.loginTap});

  @override
  State<SaraShieldWidget> createState() => _SaraShieldWidgetState();
}

class _SaraShieldWidgetState extends State<SaraShieldWidget> {
  @override
  Widget build(BuildContext context) {
    return GetX<SaraShieldController>(
      init: SaraShieldController(),
      initState: (val) {
        val.controller?.getMyDeviceInfo(screenHeight(context), screenWidth(context), widget.cieraModel);
      },
      builder: (controller) {
        return controller.isLoading.value
            ? const Center(child: LoadingWidget())
            : Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: controller.isOtherLoading.value
                        ? const LoadingWidget()
                        : ElevatedButton(
                            onPressed: () async {
                              await controller.slideButton(context, widget.cieraModel);
                              if (controller.isVerified.value) {
                                widget.loginTap(controller.isVerified.value);
                              } else {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PopupScreen(
                                      cieraModel: widget.cieraModel,
                                      visiterId: controller.visiterId.value,
                                      requestId: controller.requestId.value,
                                      loginTap: (val) {
                                        // print("val====>${val}");
                                        if (val == true) {
                                          controller.isVerified.value = true;
                                          widget.loginTap(controller.isVerified.value );
                                        }
                                      },
                                    ).alertCard(context);
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blueColor,
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            child: const Text(
                              "Submit",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.whiteColor),
                              maxLines: 1,
                            )))
                .putPadding(2, 5);
      },
    );
  }
}

class MyPlugin {
  final AssetBundle assetBundle;

  MyPlugin(this.assetBundle);

  Future<Uint8List> loadImage(String imagePath) async {
    ByteData data = await assetBundle.load(imagePath);
    return data.buffer.asUint8List();
  }
}
