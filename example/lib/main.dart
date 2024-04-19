import 'package:flutter/material.dart';
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
      body: SaraShieldWidget(
        cieraModel: CyberCieraModel(
            masterUrlId: 'VYz433DfqQ5LhBcgaamnbw4Wy4K9CyQT', //Master URl ID
            requestUrl: 'com.app.cyber_ceiara' //Package name

            ),
      ),
    );
  }
}
