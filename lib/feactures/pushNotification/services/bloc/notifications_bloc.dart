import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app/presentation/widgets/custom_app_widgets.dart';

import '../../../../app/core/utils/device_info_app.dart';
import '../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../app/domain/enums/enums.dart';
import '../../data/models/models_push_notification.dart';
import '../../domain/request/request_push_notification.dart';
import '../../domain/use_cases/insert_token_fcm.dart';
import '../localNotification/local_notification.dart';
import 'package:permission_handler/permission_handler.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

/// Handler para mensajes recibidos en segundo plano o cuando la app está cerrada
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Random random = Random();
  var id = random.nextInt(1000000);
  var mensaje = message.data;

  var body = mensaje['body'];
  var title = mensaje['title'];

  print("firebaseMessagingBackgroundHandler : $mensaje");
  final notification =
  NotificationModel.fromJson(message.data);

  print('accion: ${notification.accion}');
  print('appName: ${notification.appName}');
  print('idAccion: ${notification.idAccion}');
  print('body: ${notification.body}');
  print('title: ${notification.title}');
  print('clickAction: ${notification.clickAction}');


  LocalNotification.showLocalNotification(notification: notification);
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsInitial()) {
    print("NotificationsBloc inicializado...");

    _onForegroundMessage();

    FirebaseMessaging.onMessageOpenedApp.listen(
      _onMessageOpenedApp,
    );

    _listenTokenRefresh();
  }

  void _listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("🔄 TOKEN ACTUALIZADO: $newToken");

      // Aquí debes enviarlo a tu backend
      // insertToken(newToken);
    });
  }

  /// Solicitar permisos para notificaciones

  Future<void> requestPermission({
    List<String>? topics,
    required NamApps appName,
    required int idGenUsuario,
  }) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await LocalNotification.requestPermissionLocalNotifications();

    print("Authorization Status: ${settings.authorizationStatus}");

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ✅ OK
      await  _getFCMtoken(
        topics: topics,
        appName: appName,
        idGenUsuario: idGenUsuario,
      );
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("Usuario rechazó");
      _mostrarMensajePermisoDenegado();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      // ⚠️ Aún no decide (raro después de pedir)
      print("Usuario aún no decide");
    }
  }

  void _mostrarMensajePermisoDenegado() {
    DialogosAwesome.getInformationSiNo(
      descripcion:
      "Activa las notificaciones para recibir alertas y novedades importantes.\n\n"
          "Sin este permiso, no podremos enviarte mensajes.\n\n"
          "¿Deseas activarlas?",
      title: "Queremos mantenerte informado",
      btnOkOnPress: () {
        Get.back();
        _abrirConfiguracion();
      },
    );
  }

  void _abrirConfiguracion() async {
    await openAppSettings();
  }

// Obtener el token de FCM y suscribirse a topics
  Future<void> _getFCMtoken({
    List<String>? topics,
    required NamApps appName,
    required int idGenUsuario,
  }) async {

    const String TAG = "[FCM]";

    final settings = await messaging.getNotificationSettings();

    print("$TAG ======================================");
    print("$TAG INICIO PROCESO NOTIFICACIONES");
    print("$TAG TOPIC: ${appName.nameString}");
    print("$TAG AuthorizationStatus: ${settings.authorizationStatus}");
    print("$TAG ======================================");

    if (settings.authorizationStatus !=
        AuthorizationStatus.authorized) {

      print("$TAG ❌ Usuario no autorizó notificaciones");

      return;
    }

    String? token;

    try {

      // Solo para diagnóstico en iOS
      if (Platform.isIOS) {

        try {

          final apnsToken =
          await FirebaseMessaging.instance.getAPNSToken();

          print("$TAG 🍎 APNS TOKEN: $apnsToken");

          if (apnsToken == null) {

            print(
              "$TAG ⚠️ APNS TOKEN es NULL. "
                  "Posiblemente estás en simulador "
                  "o APNs no está configurado.",
            );
          }

        } catch (e) {

          print(
            "$TAG ❌ Error obteniendo APNS TOKEN: $e",
          );
        }
      }

      token = await FirebaseMessaging.instance.getToken();

      print("$TAG 🔥 FCM TOKEN: $token");

    } catch (e, stackTrace) {

      print("$TAG ❌ Error obteniendo FCM TOKEN");
      print("$TAG ERROR: $e");
      print("$TAG STACKTRACE: $stackTrace");

      return;
    }

    try {

      await FirebaseMessaging.instance.subscribeToTopic(
        appName.nameString,
      );

      print(
        "$TAG ✅ Suscrito al topic: ${appName.nameString}",
      );

    } catch (e) {

      print(
        "$TAG ❌ Error suscribiendo al topic: $e",
      );
    }

    if (topics != null && topics.isNotEmpty) {

      for (final topic in topics) {

        try {

          await FirebaseMessaging.instance.subscribeToTopic(
            topic,
          );

          print(
            "$TAG ✅ Suscrito al topic adicional: $topic",
          );

        } catch (e) {

          print(
            "$TAG ❌ Error suscribiendo al topic $topic: $e",
          );
        }
      }
    }

    if (token != null && token.isNotEmpty) {

      try {

        insertToken(
          tokenFcm: token,
          appName: appName.nameString,
          idGenUsuario: idGenUsuario,
        );

        print("$TAG ✅ Token enviado al backend");

      } catch (e) {

        print(
          "$TAG ❌ Error guardando token en backend: $e",
        );
      }
    }

    print("$TAG ======================================");
    print("$TAG FIN PROCESO NOTIFICACIONES");
    print("$TAG ======================================");
  }

  Future<void> updateTopics(List<String>? topics) async {
    if (topics == null || topics.isEmpty) {
      return;
    }
    for (final topicName in topics) {
      // Desuscribirse para evitar duplicados
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);

      // Suscripción al topic correspondiente
      await FirebaseMessaging.instance.subscribeToTopic(topicName);
    }
  }

  /// Enviar token al backend
  void insertToken({
    required String tokenFcm,
    required String appName,
    required int idGenUsuario,
  }) async {
    final InsertTokenFcmUseCase _insertTokenFcmUseCase =
    Get.find<InsertTokenFcmUseCase>();

    try {
      String ip = await DeviceInfoApp.getIp;
      String plataforma = await DeviceInfoApp.getOnlyPlataforma;

      PushTokenRequest request = PushTokenRequest(
        idGenUsuario: idGenUsuario,
        appName: appName,
        plataforma: plataforma,
        tokenFcm: tokenFcm,
        usuario: idGenUsuario,
        ip: ip,
      );

      final result = await _insertTokenFcmUseCase.call(request: request);
    } catch (ex) {
      print("Print error al insertar token en el server ${ex.toString()}");
    }
  }

  /// Mensajes recibidos en primer plano
  void _onForegroundMessage() {
    print("Escuchando mensajes en primer plano...");
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

// Mensajes recibidos en minimizado
  void _onMessageOpenedApp(RemoteMessage message) {

    print("========= onMessageOpenedApp =========");

    print(message.data);

    final notification =
    NotificationModel.fromJson(
      message.data,
    );

    print('accion: ${notification.accion}');
    print('appName: ${notification.appName}');
    print('idAccion: ${notification.idAccion}');
    print('body: ${notification.body}');
    print('title: ${notification.title}');
  }
  /// Manejo de mensajes en cualquier estado
  void handleRemoteMessage(RemoteMessage message) {


    print("MENSAJE RECIBIDO: ${message.data}");
    print("messageId: ${message.messageId}");
    print("collapseKey: ${message.collapseKey}");
    print("contentAvailable: ${message.contentAvailable}");



    final notification =
    NotificationModel.fromJson(message.data);

    print('accion: ${notification.accion}');
    print('appName: ${notification.appName}');
    print('idAccion: ${notification.idAccion}');
    print('body: ${notification.body}');
    print('title: ${notification.title}');
    print('clickAction: ${notification.clickAction}');


    LocalNotification.showLocalNotification(notification: notification);
  }
}
