
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siarashield_flutter/application_constants/app_constant.dart';
import 'package:siarashield_flutter/common/extension_widget.dart';
import 'package:slider_button/slider_button.dart';

import '../common/common_widgets.dart';
import '../controllers/login_controller.dart';
import '../siarashield_flutter.dart';

class LoginScreen extends StatefulWidget {
  final CyberCieraModel cieraModel;
  const LoginScreen({super.key, required this.cieraModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _txtUsername = TextEditingController();
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: AppColors.greyColor));
  final TextStyle _hintStyle = const TextStyle(color: AppColors.greyColor, fontSize: 16, fontWeight: FontWeight.w500);
  final TextStyle _labelStyle = const TextStyle(color: AppColors.blueColor, fontSize: 16, fontWeight: FontWeight.w500);
  final TextStyle _subtitle = TextStyle(color: AppColors.blackColor.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w400);
  bool isCheck = false;
  bool isSlide = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: GetX<LoginController>(
        init: LoginController(),
        initState: (val) {
          val.controller?.getMyDeviceInfo(screenHeight(context),screenWidth(context),widget.cieraModel);
        },
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(child: LoadingWidget())
              : SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: screenHeight(context) * 0.15, right: 15, left: 15),
                    decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Image.asset(
                              ImageAssets.logo,
                          scale: 1,
                        )),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: _txtUsername,
                            cursorColor: AppColors.blackColor,
                            style: _labelStyle,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 10),
                                disabledBorder: border,
                                errorBorder: border,
                                focusedBorder: border,
                                enabledBorder: border,
                                hintText: "Example@email.com",
                                hintStyle: _hintStyle,
                                labelText: "Email",
                                labelStyle: _labelStyle,
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.yellowColor,
                                ))).putPadding(15, 15),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: _txtUsername,
                            cursorColor: AppColors.blackColor,
                            style: _labelStyle,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 10),
                                disabledBorder: border,
                                errorBorder: border,
                                focusedBorder: border,
                                enabledBorder: border,
                                hintText: "*******",
                                hintStyle: _hintStyle,
                                labelText: "Password",
                                labelStyle: _labelStyle,
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: AppColors.yellowColor,
                                ))).putPadding(15, 15),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: isCheck,
                                onChanged: (val) {
                                  isCheck = !isCheck;
                                  setState(() {});
                                }),
                            Text(
                              "Remember password",
                              style: _subtitle,
                            )
                          ],
                        ).putPadding(15, 15),
                        Card(
                          color: AppColors.whiteColor,
                          shadowColor: AppColors.whiteColor,
                          semanticContainer: true,
                          surfaceTintColor: AppColors.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: controller.isVerified.value
                                            ? Container(
                                                height: 60,
                                                decoration: BoxDecoration(color: AppColors.blueColor, borderRadius: BorderRadius.circular(90)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Verified!",
                                                      style: TextStyle(color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 25,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child: Image.asset(
                                                            ImageAssets.checkCircle,
                                                            scale: 4,
                                                          ),
                                                        )),
                                                  ],
                                                ))
                                            : controller.isOtherLoading.value
                                                ? const LoadingWidget2()
                                                : SliderButton(
                                                    backgroundColor: Colors.black12,
                                                shimmer: false,
                                                disable: false,
                                                buttonSize: 50,
                                                dismissThresholds: 0.2,
                                                radius: 100,
                                                vibrationFlag: true,
                                                width: 200,
                                                action: () async {
                                                      // isSlide = !isSlide;
                                                      // setState(() {});

                                                      await controller.slideButton(context, widget.cieraModel);

                                                      // showAnimatedDialog(
                                                      //   context: context,
                                                      //   alignment: Alignment.center,
                                                      //   animationType: DialogTransitionType.slideFromBottomFade,
                                                      //   curve: Curves.fastOutSlowIn,
                                                      //   duration: const Duration(milliseconds: 500),
                                                      //   builder: (BuildContext context) {
                                                      //     return const PopupScreen().alertCard(context);
                                                      //   },
                                                      // );
                                                      return false;
                                                },
                                                alignLabel: Alignment.center,
                                                label: Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("       Human User?", style: _labelStyle),
                                                      Text("        Slide to verify", style: _hintStyle),
                                                    ],
                                                  ),
                                                ),
                                                icon: Image.asset(ImageAssets.slideArrow),
                                                // child: isSlide ? Image.asset(ImageAssets.checkCircle) : null
                                              )),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Image.asset(
                                        ImageAssets.download,
                                        scale: 4,
                                      ))
                                ],
                              ).putPadding(2, 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text("Protected by CyberSiARA",
                                          style: TextStyle(
                                              color: AppColors.blackColor.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400))),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Privacy Terms",
                                        maxLines: 1,
                                        style: TextStyle(color: AppColors.blackColor.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ).putPadding(2, 14),
                              const SizedBox(
                                height: 7,
                              )
                            ],
                          ),
                        ).putPadding(7, 7),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 13, bottom: 13),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an acoount? ",
                                style: TextStyle(color: AppColors.blackColor.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "SIGN UP",
                                style: TextStyle(color: AppColors.yellowColor, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.isVerified.value
                            ? Row(
                                children: [
                            Expanded(
                              child: AppButton(
                                onTap: () {},
                                title: "Login",
                              ),
                            ),
                          ],
                              ).putPadding(7, 7)
                            : const SizedBox(),
                        controller.isVerified.value
                            ? const SizedBox(
                                height: 15,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
              );
        },
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final GestureTapCallback onTap;

  final String title;

  const AppButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
          shadowColor: MaterialStateProperty.all<Color>(AppColors.yellowColor),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.yellowColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.whiteColor, fontSize: 18)));
  }
}
