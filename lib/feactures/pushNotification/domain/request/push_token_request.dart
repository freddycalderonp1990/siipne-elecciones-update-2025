part of 'request_push_notification.dart';

class PushTokenRequest {
  final int idGenUsuario;
  final String appName;
  final String plataforma;
  final String tokenFcm;
  final String usuario;
  final String ip;

  PushTokenRequest({
    required this.idGenUsuario,
    required this.appName,
    required this.plataforma,
    required this.tokenFcm,
    required this.usuario,
    required this.ip,
  });

  Map<String, dynamic> toJson() {
    return {
      "idGenUsuario": idGenUsuario,
      "appName": appName,
      "plataforma": plataforma,
      "tokenFcm": tokenFcm,
      "usuario": usuario,
      "ip": ip,
    };
  }
}