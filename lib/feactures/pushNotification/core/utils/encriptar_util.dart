import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../../../../../app/core/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncriptarUtil {

  static String key_securiry_pass= dotenv.env['SECRET_KEY_APP_ENCRYP'] ?? '';
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String generateSha512(String input) {
    return sha512.convert(utf8.encode(input)).toString();
  }

  static String generateSha1(String input) {
    return sha1.convert(utf8.encode(input)).toString();
  }

  static String generateSha256(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  // Función para cifrar texto
  static String encryptMovil(String text, {String? key_}) {
    String key = AppConfig.key_securiry_qr;
    if (key_ != null) {
      key = key_;
    }

    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);
      int keyCode = key.codeUnitAt(i % keyLength);
      int encryptedCharCode = (charCode + keyCode) % 256;
      result += String.fromCharCode(encryptedCharCode);
    }

    return result;
  }

// Función para descifrar texto
  static String decryptMovil(String encryptedText) {
    String key = AppConfig.key_securiry_qr;
    String result = '';
    int keyLength = key.length;

    for (int i = 0; i < encryptedText.length; i++) {
      int charCode = encryptedText.codeUnitAt(i);
      int keyCode = key.codeUnitAt(i % keyLength);
      int decryptedCharCode = (charCode - keyCode + 256) % 256;
      result += String.fromCharCode(decryptedCharCode);
    }

    return result;
  }

  static String decryptSiipne(String text) {
    String key = AppConfig.key_securiry_qr;
    String result = '';
    int keyLength = key.length;
    List<int> bytes = base64Decode(text);

    for (int i = 0; i < bytes.length; i++) {
      int byte = bytes[i];
      String keyChar =
          key[i % keyLength]; // Repetir la clave si es más corta que el texto
      result += String.fromCharCode((byte - keyChar.codeUnitAt(0) + 256) %
          256); // Resta ASCII de los caracteres
    }

    return result;
  }




  static Map<String, String> getKeyPass() {
    Map<String, String> _decryptMap = {
      '0': '8',
      '1': '5',
      '2': '6',
      '3': '4',
      '4': '9',
      '5': '2',
      '6': '0',
      '7': '1',
      '8': '3',
      '9': '7',
      'a': 'T',
      'b': 'O',
      'c': 'V',
      'd': 'Q',
      'e': 'Y',
      'f': 'P',
      'g': 'R',
      'h': 'G',
      'i': 'S',
      'j': 'W',
      'k': 'A',
      'l': 'D',
      'm': 'U',
      'n': 'F',
      'o': 'M',
      'p': 'H',
      'q': 'Z',
      'r': 'E',
      's': 'B',
      't': 'X',
      'u': 'K',
      'v': 'J',
      'w': 'I',
      'x': 'L',
      'y': 'C',
      'z': 'N',
      'A': 'w',
      'B': 'f',
      'C': 'r',
      'D': 'x',
      'E': 'p',
      'F': 'n',
      'G': 'a',
      'H': 'd',
      'I': 'h',
      'J': 'i',
      'K': 's',
      'L': 'u',
      'M': 'j',
      'N': 'k',
      'O': 'o',
      'P': 'c',
      'Q': 'b',
      'R': 'e',
      'S': 't',
      'T': 'q',
      'U': 'v',
      'V': 'z',
      'W': 'y',
      'X': 'l',
      'Y': 'm',
      'Z': 'g'
    };
    return _decryptMap;
  }



  static String asignarLlave(String clave) {
    String key = key_securiry_pass;
    Random random = Random();
    int numRandom=random.nextInt(clave.length-1)+1;

    String part1 = clave.substring(0, numRandom);
    String part2 = clave.substring(numRandom);
    String result = part1 + key + part2;

    return result;


  }


  static String myEncryptPass(String input) {

    Map<String, String> decryptMap = getKeyPass();

    StringBuffer encrypted = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      encrypted.write(decryptMap[char] ?? char);
    }
    String value= encrypted.toString();
    value = value.split('').reversed.join('');

     value=   asignarLlave(value);



    return value;


  }

  static String myDecryptPass(String input) {


    String key = key_securiry_pass;

    //remover la llave
    input= input.replaceAll(key, '');

    input = input.split('').reversed.join('');


    Map<String, String> decryptMap = getKeyPass();
    Map<String, String> reversedMap =
        decryptMap.map((key, value) => MapEntry(value, key));

    StringBuffer decrypted = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      decrypted.write(reversedMap[char] ?? char);
    }

    return decrypted.toString();

  }

  static String _generarSha256(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
