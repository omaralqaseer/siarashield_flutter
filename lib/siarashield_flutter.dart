import 'package:flutter/material.dart';
import 'package:siarashield_flutter/screens/login_screen.dart';

class SaraShieldWidget extends StatefulWidget {
  const SaraShieldWidget({super.key});

  @override
  State<SaraShieldWidget> createState() => _SaraShieldWidgetState();
}

class _SaraShieldWidgetState extends State<SaraShieldWidget> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

