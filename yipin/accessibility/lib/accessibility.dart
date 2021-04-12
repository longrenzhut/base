
import 'dart:async';

import 'package:flutter/services.dart';

class Accessibility {
  static const MethodChannel _channel =
      const MethodChannel('accessibility');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future repeatPicByWx(int count) async {
    final String  repeat = await _channel.invokeMethod('com.tencent.mm',count);
    return repeat;
  }

}
