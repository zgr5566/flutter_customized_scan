import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_customized_scan/flutter_customized_scan.dart';
import 'package:flutter_customized_scan/scan_view.dart';
import 'package:flutter_customized_scan_example/scan_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterCustomizedScan.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  MethodChannel platform = MethodChannel("flutter_customized_scan");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "ScanPage": (context) => ScanPage(),
      },
      home: Builder(builder: (context){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () async {
                      Map<Permission,PermissionStatus> status = await [Permission.camera,Permission.storage].request();

                      bool isCamera = status[Permission.camera] == PermissionStatus.granted;
                      // bool isCamera = true;
                      bool isStorage = status[Permission.storage] == PermissionStatus.granted;
                      print("isCamera:$isCamera isStorage:$isStorage");
                      bool isSucceed = isCamera && isStorage;
                      if (isSucceed) {
                        // platform.invokeMethod("startScan");
                        Navigator.pushNamed(context, "ScanPage");
                      }
                    },
                    child: Text("扫一扫")),
              ),
            ),
          ),
        );
      }),
    );
  }
}
