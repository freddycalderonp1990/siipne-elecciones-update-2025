import 'dart:io';

import 'package:app_mi_upc/app_mi_upc.dart';
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
//ok   asassa

//solucion:OS Error:   CERTIFICATE_VERIFY_FAILED
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
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
