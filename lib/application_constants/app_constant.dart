import 'package:flutter/material.dart';

abstract class ApiConstant {
  // static String baseUrl ="https://invisiblecaptcha.embed.mycybersiara.com/api/";
  // static String baseUrl ="https://embed.mycybersiara.com/api/";
  static String baseUrl ="https://embed.mycybersiara.com/api/";

  static String GetCyberSiaraForAndroid="CyberSiara/GetCyberSiaraForAndroid";

  static String VerifiedSubmitForAndroid="SubmitCaptcha/VerifiedSubmitForAndroid";

  //if successfull  to display login button

  //if fail then display on the model
  static String CaptchaForAndroid="GenerateCaptcha/CaptchaForAndroid";


  static String SubmitCaptchInfoForAndroid="SubmitCaptcha/SubmitCaptchInfoForAndroid";

}

abstract class ImageAssets{
  // /Users/apple/Desktop/andrew projects/siarashield_flutter/assets
  static const String asset="assets/";
  static const String checkCircle="${asset}check-circle.gif";
  static const String close="${asset}close.png";
  static const String dot="${asset}dots.png";
  static const String download="${asset}download.png";
  static const String hide="${asset}hide.png";
  static const String logo="assets/logo.png";
  static const String refreshPage="${asset}refresh-page-option.png";
  static const String rightCaptcha="${asset}RightCaptcha.gif";
  static const String slideArrow="${asset}slideArrow.png";
  static const String view="${asset}view.png";

}



abstract class AppColors {
  AppColors._();
  static const Color blueColor = Color(0xff0081c9);
  static const Color blackColor = Color(0xff000000);
  static const Color blueLightColor = Color(0xff425363);
  static const Color lightBlueColor = Color(0xffb3daef);
  static const Color greenColor = Colors.green;
  static const Color redColor = Colors.red;
  static const Color tealColor = Colors.cyan;
  static const Color  whiteColor = Colors.white;
  static Color yellowColor = const Color(0xffefb546);
  static const Color greyColor = Colors.grey;
  static const Color greyColor2 = Color(0xff171616);
  static const Color orangeColor = Color(0xffed7700);
  static const Color pinkColor = Color(0xffeb536a);
  static const Color purpleColor = Colors.purple;
}