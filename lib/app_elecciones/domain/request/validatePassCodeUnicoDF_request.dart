part of 'request.dart';

class ValidatePassCodeUnicoDFRequest {
  final String user;
  final String pass;

  final String codigoUnico;
  final bool validatePass;
  final bool validateCode;

  ValidatePassCodeUnicoDFRequest({
    required this.user,
    required this.pass,
    required this.codigoUnico,
    required this.validatePass,
    required this.validateCode
  });
}
