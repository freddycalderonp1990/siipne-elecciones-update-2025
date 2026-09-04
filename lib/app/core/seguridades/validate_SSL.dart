import 'dart:io';
import 'package:api_provider/api_provider.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ValidateSSL {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _publicKeyHashKey = 'publicKeyHash';

  /// Realiza la conexión inicial al servidor y guarda el hash localmente
  Future<void> storePublicKeyHash(Uri url) async {
    final client = CustomHttpClient();
    try {
      final certificate = await client.getServerCertificate(url).timeout(
        Duration(seconds: ApiConfig.secondsTimeout),
        onTimeout: () {
          print('Tiempo de espera agotado al obtener el certificado.');
          return null;
        },
      );

      if (certificate != null) {
        final publicKeyHash = sha256.convert(certificate).toString();
        await _storage.write(key: _publicKeyHashKey, value: publicKeyHash);
        print('Hash del certificado guardado localmente.');
      } else {
        print('No se pudo obtener el certificado del servidor.');
      }
    } catch (e) {
      print('Error en storePublicKeyHash: $e');
    }
  }

  Future<bool> validatePublicKeyHash(Uri url) async {
    final client = CustomHttpClient();
    try {
      final certificate = await client.getServerCertificate(url).timeout(
        Duration(seconds: ApiConfig.secondsTimeout),
        onTimeout: () {
          print('Tiempo de espera agotado al obtener el certificado.');
          return null;
        },
      );

      if (certificate == null) {
        print('No se pudo obtener el certificado del servidor.');
        return false;
      }

      final publicKeyHash = sha256.convert(certificate).toString();
      final storedHash = await _storage.read(key: _publicKeyHashKey);

      if (storedHash != null && storedHash == publicKeyHash) {
        print('Validación del certificado exitosa.');
        return true;
      }

      print('El certificado no coincide con el hash guardado.');
      return false;
    } catch (e) {
      print('Error en validatePublicKeyHash: $e');
      return false;
    }
  }

  Future<bool> validarSSl() async {
    final url = HostApp.gethost(segmento: '');
    final uri = Uri.parse(url);

    await storePublicKeyHash(uri);
    return await validatePublicKeyHash(uri);
  }
}

class CustomHttpClient {
  final HttpClient _httpClient;

  CustomHttpClient() : _httpClient = HttpClient();

  Future<HttpClientResponse> get(Uri url) async {
    final request = await _httpClient.getUrl(url);
    return await request.close();
  }

  /// Obtiene el certificado del servidor
  Future<List<int>?> getServerCertificate(Uri url) async {
    try {
      final request = await _httpClient.getUrl(url);
      final response = await request.close();
      final X509Certificate? certificate = response.certificate;
      if (certificate != null) return certificate.der;
    } catch (e) {
      print('Error al obtener el certificado: $e');
    }
    return null;
  }

  void close() {
    _httpClient.close();
  }
}