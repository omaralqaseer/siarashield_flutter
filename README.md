# siarashield_flutter

To authenticate using siarashield


## Getting started

To use this package, add siarashield_flutter as a dependency in your pubspec.yaml file.

## Usage
This MasterUrlId you will  get from this webist when you add your package name.

https://mycybersiara.com/

Minimal example:

```dart
    SaraShieldWidget(
    loginTap: (bool isSuccess) {
      if (isSuccess) {
          //To-Do On Success
        print("Tapped==>$isSuccess");
        }
      },
      cieraModel: CyberCieraModel(
      masterUrlId: 'GIGYGUgeyiy86786BJHBIY', //Master URl ID
      requestUrl: 'com.app.testapp' //Package name,
      privateKey: "YUFRGF&31293", //Private Key
),
),
),
```



