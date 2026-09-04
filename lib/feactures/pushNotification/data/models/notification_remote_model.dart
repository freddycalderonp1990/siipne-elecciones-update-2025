part of 'models_push_notification.dart';


NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final String accion;
  final String appName;
  final String idAccion;
  final String body;
  final String title;
  final String clickAction;

  NotificationModel({
    required this.accion,
    required this.appName,
    required this.idAccion,
    required this.body,
    required this.title,
    required this.clickAction,
  });

  NotificationModel copyWith({
    String? accion,
    String? appName,
    String? idAccion,
    String? body,
    String? title,
    String? clickAction,
  }) =>
      NotificationModel(
        accion: accion ?? this.accion,
        appName: appName ?? this.appName,
        idAccion: idAccion ?? this.idAccion,
        body: body ?? this.body,
        title: title ?? this.title,
        clickAction: clickAction ?? this.clickAction,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        accion: ParseModel.parseToString(json["accion"]),
        appName: ParseModel.parseToString(json["app_name"]),
        idAccion: ParseModel.parseToString(json["idAccion"]),
        body: ParseModel.parseToString(json["body"]),
        title: ParseModel.parseToString(json["title"]),
        clickAction: ParseModel.parseToString(json["click_action"]),
      );

  Map<String, dynamic> toJson() => {
    "accion": accion,
    "app_name": appName,
    "idAccion": idAccion,
    "body": body,
    "title": title,
    "click_action": clickAction,
  };
}