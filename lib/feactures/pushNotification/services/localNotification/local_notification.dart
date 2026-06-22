import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/models/models_push_notification.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Solicitar permisos (Android 13+ y iOS)
  static Future<void> requestPermissionLocalNotifications() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Inicializar notificaciones
  static Future<void> initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings(
      '@drawable/ic_notificacion',
    );

    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (
          NotificationResponse response,
          ) {
        try {

          if (response.payload == null ||
              response.payload!.isEmpty) {
            return;
          }

          final notification =
          notificationModelFromJson(
            response.payload!,
          );

          print("========== CLICK NOTIFICACION ==========");
          print("accion: ${notification.accion}");
          print("idAccion: ${notification.idAccion}");
          print("appName: ${notification.appName}");
          print("title: ${notification.title}");
          print("body: ${notification.body}");
          print("========================================");


          switch (notification.accion) {

            case "abrir_censo":

              print(
                "Abrir pantalla de censo: ${notification.idAccion}",
              );

              // navigatorKey.currentState?.pushNamed(
              //   '/detalleCenso',
              //   arguments: notification.idAccion,
              // );

              break;

            case "abrir_eleccion":

              print(
                "Abrir pantalla de elecciones: ${notification.idAccion}",
              );

              // navigatorKey.currentState?.pushNamed(
              //   '/detalleEleccion',
              //   arguments: notification.idAccion,
              // );

              break;
          }

        } catch (e) {
          print(
            "Error procesando payload de notificación: $e",
          );
        }
      },
    );
  }

  /// Mostrar notificación
  static Future<void> showLocalNotification({
    required NotificationModel notification,
  }) async {
    Random random = Random();
    var id = random.nextInt(1000000);
    /*
    SnackbarService.show(
      titulo: title!=null?title:'No tilte',
      subtitulo: body!=null?body:'No body',
      imagenDerecha: "imgBase64",

    );*/

    const androidDetails = AndroidNotificationDetails(
      'default_channel_id', // 👈 obligatorio en Android 8+
      'General Notifications', // 👈 nombre visible del canal
      channelDescription: 'Canal de notificaciones por defecto',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/launcher_icon', // ✅ funciona seguro
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id,
      notification.title,
      notification.body,
      notificationDetails,
      payload: notificationModelToJson(notification),
    );
  }
}
