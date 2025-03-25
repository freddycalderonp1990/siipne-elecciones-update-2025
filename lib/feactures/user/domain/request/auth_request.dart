part of 'request_user.dart';
class AuthRequest {
  final String user;
  final String pass;
  final bool isAndroid;
  final String ip;

  final int versionCodeApp;


  AuthRequest({required this.user, required this.pass, required this.isAndroid, required this.versionCodeApp,
  required this.ip});

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "pass": pass,
      "isAndroid": isAndroid,
      "versionCodeApp": versionCodeApp,
      "ip": ip,

    };


  }
}
