import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app/presentation/widgets/custom_app_widgets.dart';



import '../../presentation/modules/controllers.dart';
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

  LocalNotification.showLocalNotification(id: id, title: title, body: body);
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsInitial()) {
    print("NotificationsBloc inicializado...");
    _onForegroundMessage();
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




  void requestPermission(String nameTopic) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await LocalNotification.requestPermissionLocalNotifications();

    print("Authorization Status: ${settings.authorizationStatus}");

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ✅ OK
      _getFCMtoken(nameTopic);

    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {

      print("Usuario rechazó");
      _mostrarMensajePermisoDenegado();

    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      // ⚠️ Aún no decide (raro después de pedir)
      print("Usuario aún no decide");
    }
  }


  void _mostrarMensajePermisoDenegado() {

    DialogosAwesome.getInformationSiNo(
      descripcion: "Activa las notificaciones para recibir alertas y novedades importantes.\n\n"
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





  /// Obtener el token de FCM y suscribirse a topics
  void _getFCMtoken(String nameTopic) async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;



    final token = await messaging.getToken();
    String topicName = nameTopic;

    print("Topic actual: $topicName");
    print("NOTIFICACIONES-> El TOKEN es: $token");

    // Desuscribirse para evitar duplicados
    await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);


    // Suscripción al topic correspondiente
    await FirebaseMessaging.instance.subscribeToTopic(topicName);

    if (token != null) {
      //insertToken(token);
    }
  }

  /*
  /// Enviar token al backend
  void insertToken(String token) async {
    final AuthApiImpl _apiUserRepository = Get.find<AuthApiImpl>();

    String versionApp = await UtilidadesUtil.getVersionCodeNameApp();
    String ip = await DeviceInfo.getIp;
    String versionSOCell = await DeviceInfo.getVersionSO;
    String modeloCell = await DeviceInfo.getNameDevice;

    final LoginController loginController = Get.find<LoginController>();

    TokenInsertRequest tokenInsertRequest = TokenInsertRequest(
      publicidad: loginController.user.value.publicidad,
      idUsuario: loginController.user.value.idUser,
      token: token,
      idTopicFcm: loginController.user.value.idTopicFcm,
      fecha: MyDate.getFechaHoraActual,
      modCelular: modeloCell,
      versionSOCell: versionSOCell,
      ip: ip,
    );

    _apiUserRepository.inserTokenFCM(tokenInsertRequest);
  }
*/
  /// Mensajes recibidos en primer plano
  void _onForegroundMessage() {
    print("Escuchando mensajes en primer plano...");
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  /// Manejo de mensajes en cualquier estado
  void handleRemoteMessage(RemoteMessage message) {
    Random random = Random();
    var id = random.nextInt(1000000);

    print("MENSAJE RECIBIDO: ${message.data}");
    print("messageId: ${message.messageId}");
    print("collapseKey: ${message.collapseKey}");
    print("contentAvailable: ${message.contentAvailable}");

    var mensaje = message.data;
    var body = mensaje['body'];
    var title = mensaje['title'];


    LocalNotification.showLocalNotification(id: id, title: title, body: body);
  }
}
