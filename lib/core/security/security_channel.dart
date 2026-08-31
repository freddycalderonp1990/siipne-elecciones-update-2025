import 'package:flutter/services.dart';

class SecurityChannel {
  static const MethodChannel _channel = MethodChannel('ec.gob.policia/security');

  static Future<Map<dynamic, dynamic>> validateDevice() async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('validateDevice');
      return result ?? {};
    } on PlatformException catch (e) {
      throw Exception('Error en la validación de seguridad: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado en la validación de seguridad: $e');
    }
  }
}