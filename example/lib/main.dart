import 'package:flutter/material.dart';
import 'package:siarashield_flutter/application_constants/app_constant.dart';
import 'package:siarashield_flutter/common/common_widgets.dart';
import 'package:siarashield_flutter/common/extension_widget.dart';
import 'package:siarashield_flutter/siarashield_flutter.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _txtUsername = TextEditingController();
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: AppColors.greyColor));
  final TextStyle _hintStyle = const TextStyle(color: AppColors.greyColor, fontSize: 16, fontWeight: FontWeight.w500);
  final TextStyle _labelStyle = const TextStyle(color: AppColors.blueColor, fontSize: 16, fontWeight: FontWeight.w500);
  final TextStyle _subtitle = const TextStyle(color: AppColors.greyColor, fontSize: 15, fontWeight: FontWeight.w400);
  bool isCheck = false;
  bool isSlide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
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
          children: [
            Center(
                child: Image.asset(
              ImageAssets.logo,
              scale: 1,
              package: 'siarashield_flutter',
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SaraShieldWidget(
                loginTap: (bool isSuccess) {
                  if (isSuccess) {
                    //To-Do On Success
                  }
                },
                cieraModel: CyberCieraModel(
                  masterUrlId: 'VYz433DfqQ5LhBcgaamnbw4Wy4K9CyQT', //Master URl ID
                  requestUrl: 'com.app.cyber_ceiara', //Package name,
                  privateKey: "1AnVf4WsYsbyDRflfBInOe42vTnnMxbu", //Private Key
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
