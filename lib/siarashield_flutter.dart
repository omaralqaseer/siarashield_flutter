import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siarashield_flutter/common/extension_widget.dart';
import 'package:siarashield_flutter/constants/app_constant.dart';
import 'package:siarashield_flutter/popup_screen.dart';

import 'common/common_widgets.dart';
import 'constants/shared_prefrence_storage.dart';
import 'controllers/sara_shield_controller.dart';

class CyberCieraModel {
  late final String masterUrlId;
  late final String requestUrl;
  late final String privateKey;

  CyberCieraModel({required this.masterUrlId, required this.requestUrl, required this.privateKey});
}

class SaraShieldWidget extends StatefulWidget {
  final CyberCieraModel cieraModel;
  final Function(bool isTrue) loginTap;

  const SaraShieldWidget({super.key, required this.cieraModel, required this.loginTap});

  @override
  State<SaraShieldWidget> createState() => _SaraShieldWidgetState();
}

class _SaraShieldWidgetState extends State<SaraShieldWidget> {
  Future<bool> checkStorage() async {
    bool isVerified = false;
    try {
      Map<String, dynamic>? token = await getToken();
      if (token == null || token.isEmpty) {
        setToken({"Token": widget.cieraModel.privateKey, "isVerified": false});
      } else if (token["Token"] == widget.cieraModel.privateKey && token["isVerified"] == true) {
        isVerified = true;
      } else if (token["Token"] == widget.cieraModel.privateKey && token["isVerified"] == false) {
        isVerified = false;
      } else if (token["Token"] != widget.cieraModel.privateKey) {
        setToken({"Token": widget.cieraModel.privateKey, "isVerified": false});
        isVerified = false;
      }
    } catch (e) {
      log("err==>±$e");
    }
    return isVerified;
  }
  // SaraShieldController controller = Get.put(SaraShieldController());

  @override
  Widget build(BuildContext context) {
    return GetX<SaraShieldController>(
      init: SaraShieldController(),
      initState: (val) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          val.controller?.getMyDeviceInfo(screenHeight(context), screenWidth(context), widget.cieraModel);
        });
      },
      builder: (controller) {
        return controller.isLoading.value
            ? const Center(child: LoadingWidget())
            : Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: controller.isOtherLoading.value
                        ? const LoadingWidget()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  bool isVerified = await checkStorage();
                                  if (isVerified) {
                                    widget.loginTap(true);
                                    return;
                                  }
                                  if (!context.mounted) return;
                                  await controller.slideButton(context, widget.cieraModel);
                                  if (controller.isVerified.value) {
                                    setToken({"Token": widget.cieraModel.privateKey, "isVerified": true});
                                  } else if (!controller.isVerified.value && controller.apiError.value.isEmpty) {
                                    if (!context.mounted) return;
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PopupScreen(
                                          cieraModel: widget.cieraModel,
                                          visiterId: controller.visiterId.value,
                                          requestId: controller.requestId.value,
                                          loginTap: (val) {
                                            if (val == true) {
                                              controller.isVerified.value = true;
                                              setToken({"Token": widget.cieraModel.privateKey, "isVerified": true});
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
                                )),
                          ))
                .putPadding(2, 5);
      },
    );
  }

  @override
  void dispose() {
    Get.delete<SaraShieldController>();
    super.dispose();
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
