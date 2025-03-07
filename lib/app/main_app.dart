import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siipnelecciones3/app/presentation/modules/splash/local_widget/loading_splash.dart';
import 'package:siipnelecciones3/app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../app/dependency_injection_app.dart';
import '../../../../../app/presentation/routes/app_routes.dart';

import '../app_elecciones/core/siipne_config.dart';
import '../app_elecciones/presentation/widgets/customWidgets.dart';
import 'core/app_config.dart';
import 'core/utils/responsiveUtil.dart';
import 'core/utils/utilidadesUtil.dart';
import 'core/values/app_colors.dart';
import 'presentation/routes/app_pages.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme,
      theme: ThemeData(
        fontFamily: 'Bookman Old Style',
        primarySwatch:UtilidadesUtil.convertirAColorMaterial(AppColors.colorAzul_1),
      ),

      locale: Locale('es'),
      // translations will be displayed in that locale
      fallbackLocale: Locale('es'),
      initialRoute:AppRoutes.SPLASH_APP ,
      initialBinding: DependencyInjectionApp(),
      getPages: AppPages.getPages(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Mi UPC'),
          ),
        ),
      ),
    );
  }
}