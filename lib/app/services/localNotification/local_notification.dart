import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../presentation/widgets/notificaciones/snackbarService.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Solicitar permisos (Android 13+ y iOS)
  static Future<void> requestPermissionLocalNotifications() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Inicializar notificaciones
  static Future<void> initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@drawable/ic_notificacion');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _notificationsPlugin.initialize(initSettings);
  }

  /// Mostrar notificación
  static Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {


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

    const notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(id, title, body, notificationDetails,
        payload: payload);
  }
}
