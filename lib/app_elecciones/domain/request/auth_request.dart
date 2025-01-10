part of 'request.dart';
class AuthRequest {
  final String user;
  final String pass;
  final bool isAndroid;
  final String ip;

  final int versionCodeApp;
  final String imei;
  final String tipoRed;
  final String nameRed;

  AuthRequest({required this.user, required this.pass, required this.isAndroid, required this.versionCodeApp,
    required this.imei, required this.tipoRed, required this.nameRed, required this.ip});
}
