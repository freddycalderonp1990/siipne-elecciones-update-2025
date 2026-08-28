import 'package:flutter/services.dart';

class SecurityChannel {

  static const MethodChannel _channel =
  MethodChannel("ec.gob.policia/security");

  static Future<Map<dynamic, dynamic>> validateDevice() async {

    final result =
    await _channel.invokeMethod<Map<dynamic, dynamic>>(
      "validateDevice",
    );

    return result ?? {};
  }
}