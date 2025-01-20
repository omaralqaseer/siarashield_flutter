import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siarashield_flutter/common/common_widgets.dart';

import 'main.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AppButton(
                onTap: () {
                  Get.offAll(() => MyApp());
                },
                title: "Logout"),
          ),
        ],
      ),
    );
  }
}
