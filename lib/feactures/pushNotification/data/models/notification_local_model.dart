part of 'models_push_notification.dart';

class NotificationLocalModel {
  final int? id;
  final int? idGenUsuario;
  final String accion;
  final String appName;
  final String idAccion;
  final String body;
  final String title;
  final String clickAction;

  final bool leida;
  final String fecha;

  NotificationLocalModel({
    this.id,
    required this.idGenUsuario,
    required this.accion,
    required this.appName,
    required this.idAccion,
    required this.body,
    required this.title,
    required this.clickAction,
    required this.leida,
    required this.fecha,
  });

  NotificationLocalModel copyWith({
    int? id,
    int? idGenUsuario,
    String? accion,
    String? appName,
    String? idAccion,
    String? body,
    String? title,
    String? clickAction,
    bool? leida,
    String? fecha,
  }) =>
      NotificationLocalModel(
        id: id ?? this.id,
        idGenUsuario: idGenUsuario??this.idGenUsuario,
        accion: accion ?? this.accion,
        appName: appName ?? this.appName,
        idAccion: idAccion ?? this.idAccion,
        body: body ?? this.body,
        title: title ?? this.title,
        clickAction: clickAction ?? this.clickAction,
        leida: leida ?? this.leida,
        fecha: fecha ?? this.fecha,
      );

  factory NotificationLocalModel.fromMap(Map<String, dynamic> map) {
    return NotificationLocalModel(
      id: map["id"],
      idGenUsuario: map["idGenUsuario"],
      accion: ParseModel.parseToString(map["accion"]),
      appName: ParseModel.parseToString(map["appName"]),
      idAccion: ParseModel.parseToString(map["idAccion"]),
      body: ParseModel.parseToString(map["body"]),
      title: ParseModel.parseToString(map["title"]),
      clickAction: ParseModel.parseToString(map["clickAction"]),
      leida: map["leida"] == 1,
      fecha: ParseModel.parseToString(map["fecha"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "accion": accion,
      "appName": appName,
      "idAccion": idAccion,
      "body": body,
      "title": title,
      "clickAction": clickAction,
      "leida": leida ? 1 : 0,
      "fecha": fecha,
      "idGenUsuario":idGenUsuario
    };
  }

  /// Convierte una notificación remota en una local
  factory NotificationLocalModel.fromRemote(
      NotificationModel notification,
  {required int idGenUsuario}
      ) {
    return NotificationLocalModel(
      accion: notification.accion,
      appName: notification.appName,
      idAccion: notification.idAccion,
      body: notification.body,
      title: notification.title,
      clickAction: notification.clickAction,
      leida: false,
      fecha: DateTime.now().toIso8601String(),
      idGenUsuario: idGenUsuario
    );
  }
}