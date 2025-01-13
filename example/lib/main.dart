import 'package:flutter/material.dart';
import 'package:siarashield_flutter/application_constants/app_constant.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SaraShieldWidget(
            loginTap: (bool isSuccess) {
              if (isSuccess) {
                //To-Do On Success
                print("Tapped==>$isSuccess");
              }
            },
            cieraModel: CyberCieraModel(
                masterUrlId: 'VYz433DfqQ5LhBcgaamnbw4Wy4K9CyQT', //Master URl ID
                requestUrl: 'com.app.cyber_ceiara' //Package name,

                ),
          ),
        ),
      ),
    );
  }
}
