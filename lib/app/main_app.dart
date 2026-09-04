
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../app/di_app.dart';
import '../../../../../app/presentation/routes/app_routes.dart';

import 'presentation/routes/app_pages.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme,
      /*theme: ThemeData(
        fontFamily: 'Century Gothic',
        primarySwatch:UtilidadesUtil.convertirAColorMaterial(AppColors.colorAzul_1),
      ),*/

      locale: Locale('es'),
      // translations will be displayed in that locale
      fallbackLocale: Locale('es'),
      initialRoute:AppRoutes.SPLASH_APP ,
      initialBinding: DependencyInjectionApp(),
      getPages: AppPages.getPages(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(''),
          ),
        ),
      ),
    );
  }
}