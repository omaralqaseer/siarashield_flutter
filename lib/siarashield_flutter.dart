import 'package:flutter/material.dart';
import 'package:siarashield_flutter/screens/login_screen.dart';

class CyberCieraModel{
  late final String masterUrlId;
  late final String requestUrl;
  CyberCieraModel({required this.masterUrlId,required this.requestUrl});
}
class SaraShieldWidget extends StatefulWidget {
  final CyberCieraModel cieraModel;
  const SaraShieldWidget({super.key, required this.cieraModel});

  @override
  State<SaraShieldWidget> createState() => _SaraShieldWidgetState();
}

class _SaraShieldWidgetState extends State<SaraShieldWidget> {
  @override
  Widget build(BuildContext context) {
    return  LoginScreen(cieraModel: widget.cieraModel,);
  }
}

