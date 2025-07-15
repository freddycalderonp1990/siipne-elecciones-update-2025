
import 'dart:convert';
class TokenUtil{




 static int extractIdGenUsuario(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return 0;

      final payload = parts[1];

      // Rellenar base64 si es necesario
      String normalized = base64.normalize(payload);
      final payloadMap = json.decode(utf8.decode(base64Url.decode(normalized)));

      return payloadMap['data']?['idGenUsuario'];
    } catch (e) {
      print('Error al decodificar el token: $e');
      return 0;
    }
  }

}