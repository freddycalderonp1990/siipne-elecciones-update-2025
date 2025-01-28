import 'dart:io';

import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siipnelecciones3/app/presentation/blocs/calculadora/calculadora_bloc.dart';
import 'package:siipnelecciones3/app/presentation/blocs/location/location_bloc.dart';

import '../app/dependency_injection_app.dart';

import 'app/core/values/app_colors.dart';
import 'app/main_app.dart';
import 'app/presentation/blocs/gps/gps_bloc.dart';
import 'app/presentation/routes/app_routes.dart';
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
  AppRoutesMiUpc.setNameMenu(name: "Home");
  AppRoutesMiUpc.setPageInicio(AppRoutes.SPLASH_APP);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => GpsBloc()),
    BlocProvider(create: (context) => LocationBloc()),
    BlocProvider(create: (context) => CalculadoraBloc()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}
