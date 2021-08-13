
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCustomizedScan {
  static const MethodChannel _channel = const MethodChannel('flutter_customized_scan');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
