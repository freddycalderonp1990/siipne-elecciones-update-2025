
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../data/provider/providers_impl_app.dart';
import '../../app_config.dart';



class ValidateSSL{
  /// Realiza la conexión inicial al servidor y guarda el hash localmente
  Future<void> storePublicKeyHash(Uri url) async {

    final client = CustomHttpClient();
    try {
      final certificate = await client.getServerCertificate(url).timeout(
         Duration(seconds: AppConfig.secondsTimeout),
        onTimeout: () {
          print("Tiempo de espera agotado al obtener el certificado.");
          return null; // Retorna null en caso de timeout
        },
      );

      if (certificate != null) {
        final publicKeyHash = sha256.convert(certificate).toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('publicKeyHash', publicKeyHash);
        print('Hash del certificado guardado localmente: $publicKeyHash');
      } else {
        print('No se pudo obtener el certificado del servidor.');
      }
    } catch (e) {
      print('Error en storePublicKeyHash: $e');
    }
  }


  Future<bool> validatePublicKeyHash(Uri url) async {
    final client = CustomHttpClient();
    // Obtén el certificado del servidor
    final certificate = await client.getServerCertificate(url).timeout(
      Duration(seconds: AppConfig.secondsTimeout),
      onTimeout: () {
        print("Tiempo de espera agotado al obtener el certificado.");
        return null; // Retorna null en caso de timeout
      },
    );
    if (certificate != null) {
      // Calcula el hash del certificado actual
      final publicKeyHash = sha256.convert(certificate).toString();
      // Recupera el hash guardado
      final prefs = await SharedPreferences.getInstance();
      final storedHash = prefs.getString('publicKeyHash');
      // Compara los hashes
      if (storedHash == publicKeyHash) {
        print('Validación del certificado exitosa.');
        return true;
      } else {
        print('El certificado no coincide con el hash guardado.');
        return false;
      }
    } else {
      print('No se pudo obtener el certificado del servidor.');
      return false;
    }
  }

  Future<bool> validarSSl() async {
    String url = HostApp.gethost(segmento: '');
    final uri = Uri.parse(url);
    ValidateSSL validateSSL=ValidateSSL();
    // Guarda el hash en la primera conexión
    await validateSSL.storePublicKeyHash(uri);
    // En conexiones futuras, valida el hash
    final isValid = await validateSSL.validatePublicKeyHash(uri);
    if (isValid) {
      return true;
    } else {
      return false;
    }
  }



}




/// Cliente HTTPS personalizado para obtener certificados del servidor
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

      // Obtiene los certificados del servidor
      final X509Certificate? certificates = response.certificate;
      if (certificates != null ) {
        // Devuelve el certificado en formato DER
        return certificates.der;
      }
    } catch (e) {
      print('Error al obtener el certificado: $e');
    }
    return null;
  }
}