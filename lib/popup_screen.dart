import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:siarashield_flutter/application_constants/app_constant.dart';

import 'common/common_widgets.dart';
import 'controllers/popoup_controller.dart';
import 'siarashield_flutter.dart';

class PopupScreen extends StatefulWidget {
  final String visiterId;
  final String requestId;
  final CyberCieraModel cieraModel;
  final Function(bool isSuccess) loginTap;

  const PopupScreen({super.key, required this.visiterId, required this.requestId, required this.cieraModel, required this.loginTap});

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {
  final TextStyle _t1 = const TextStyle(color: AppColors.blackColor, fontSize: 13, fontWeight: FontWeight.w500);
  String dropdownvalue = "English";
  var items = ["English", "Hindi"];
  final TextEditingController _txtUsername = TextEditingController();
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: AppColors.greyColor));

  @override
  Widget build(BuildContext context) {
    return GetX<PopupController>(
      init: PopupController(),
      initState: (val) {
        val.controller
            ?.getCaptcha(height: screenHeight(context), width: screenWidth(context), visiterId: widget.visiterId, cieraModel: widget.cieraModel);
      },
      builder: (controller) {
        return LoadingStateWidget(
          isLoading: controller.isLoading.value,
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImageAssets.download,
                      scale: 6,
                      package: 'siarashield_flutter',
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.blackColor,
                          size: 25,
                        ))
                  ],
                ),
                const SizedBox(height: 12),
                Text("Type all the displayed letters", style: _t1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: controller.isOtherLoading.value
                          ? const LoadingWidget()
                          : SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: cachedImageForItem(controller.captchaUrl.value, height: 60, boxFit: BoxFit.fitWidth),
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          controller.getCaptcha(
                              height: screenHeight(context), width: screenWidth(context), visiterId: widget.visiterId, cieraModel: widget.cieraModel);
                        },
                        child: Image.asset(ImageAssets.refreshIcon, scale: 2.5, package: 'siarashield_flutter'),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: SizedBox(
                        height: 45,
                        child: TextFormField(
                            controller: _txtUsername,
                            cursorColor: AppColors.blackColor,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 18),
                            maxLength: 4,
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
                            // Removes the counter

                            onChanged: (val) async {
                              if (val.length == 4) {
                                bool isSuccess = await controller.submitCaptcha(
                                    requestId: widget.requestId, visiterId: widget.visiterId, txt: _txtUsername.text, cieraModel: widget.cieraModel);
                                if (isSuccess) {
                                  widget.loginTap(true);
                                  if (context.mounted) Navigator.pop(context, true);
                                } else {
                                  toast("You have enter wrong code");
                                  if (!context.mounted) return;
                                  controller.getCaptcha(
                                      height: screenHeight(context),
                                      width: screenWidth(context),
                                      visiterId: widget.visiterId,
                                      cieraModel: widget.cieraModel);
                                }
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              disabledBorder: border,
                              errorBorder: border,
                              focusedBorder: border,
                              enabledBorder: border,
                            )),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(flex: 4, child: Text("Type all the displayed letters", style: _t1)),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                // Center(
                //   child: SizedBox(
                //     width: 200,
                //     child: AppButton(
                //         onTap: () async {
                //           if (_txtUsername.text.isEmpty) {
                //             return;
                //           }
                //
                //           await controller.submitCaptcha(
                //               requestId: widget.requestId, visiterId: widget.visiterId, txt: _txtUsername.text, cieraModel: widget.cieraModel);
                //           if (controller.isSuccess.value) {
                //             widget.loginTap(true);
                //             if (context.mounted) Navigator.pop(context, true);
                //           } else {
                //             toast("You have enter wrong code");
                //             if (!context.mounted) return;
                //             controller.getCaptcha(
                //                 height: screenHeight(context),
                //                 width: screenWidth(context),
                //                 visiterId: widget.visiterId,
                //                 cieraModel: widget.cieraModel);
                //           }
                //         },
                //         title: "Submit"),
                //   ),
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Protected by CyberSiARA",
                        style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ImageAssets.download,
                        scale: 8,
                        color: AppColors.greyColor,
                        package: 'siarashield_flutter',
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text(
                    "Privacy Terms",
                    style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
