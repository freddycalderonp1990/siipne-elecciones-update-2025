import 'dart:io';

import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../app/di_app.dart';

import 'app/core/app_config.dart';

import 'app/core/seguridades/validate_SSL.dart';
import 'app/main_app.dart';

import 'app/presentation/routes/app_routes.dart';

import 'feactures/gps/presentation/bloc/gps/gps_bloc.dart';
import 'feactures/gps/presentation/location/location_bloc.dart';

//librerias para notificaciones

import 'package:firebase_core/firebase_core.dart';
import 'feactures/pushNotification/data/models/models_push_notification.dart';
import 'feactures/pushNotification/services/bloc/notifications_bloc.dart';
import 'feactures/pushNotification/services/localNotification/local_notification.dart';
import 'firebase_options.dart';


//solucion:OS Error:   CERTIFICATE_VERIFY_FAILED
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// === Handler para notificaciones en segundo plano
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Mostrar notificación local si llega en background
  if (message.notification != null) {

    NotificationModel notification =
    NotificationModel.fromJson(
      message.data,
    );

  notification=  notification.copyWith(
      title:
      '${message.notification?.title ?? ''} ${notification.appName ?? ''}',
    body: message.notification?.body) ;



    await LocalNotification.showLocalNotification(
    notification: notification
    );
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  DependencyInjectionApp();

  await dotenv.load(fileName: ".env");

  AppConfig.init();

  AppRoutesMiUpc.setNameMenu(name: "Home");
  AppRoutesMiUpc.setPageInicio(AppRoutes.SPLASH_APP);

  try {
    //validamos si el certificado SSl corresponde al SIIPNE 3w
    ValidateSSL validateSSL = ValidateSSL();
    await validateSSL.validarSSl();
  } catch (e) {
    print("error certificados $e");
  }


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  try{
    // Inicializar Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Configurar handler en background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Inicializar notificaciones locales
    await LocalNotification.initializeLocalNotifications();

    // === Solicitar permisos de notificación (iOS + Android 13+) 👇
   // await LocalNotification.requestPermissionLocalNotifications();
  }
  catch (e){
    print(" Error en Firebase Notificaciones: ${e.toString()}");
}

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => NotificationsBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}
