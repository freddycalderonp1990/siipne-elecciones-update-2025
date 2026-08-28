import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/presentation/widgets/custom_app_widgets.dart';
import 'feactures/pushNotification/di.dart';


class DesingAppRoot extends StatefulWidget {

  const DesingAppRoot({super.key});

  @override
  State<DesingAppRoot> createState() => _DesingAppRootState();
}

class _DesingAppRootState extends State<DesingAppRoot> {

  @override
  Widget build(BuildContext context) {
    DependencyInjectionPushNotification.init();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme,
      theme: ThemeData(
        fontFamily: 'Bookman Old Style',
      ),
      locale: Locale('es'),
      // translations will be displayed in that locale
      fallbackLocale: Locale('es'),
      home: WorkAreaPageWidget(peticionServer: false.obs, contenido: 
      Center(child:
          TextSombrasWidget(
            size: 28,
              title: "Por razones de seguridad, no podemos permitir el uso de esta aplicación en dispositivos rooteados. "
              "\n\nPara continuar, por favor, restaura tu dispositivo a su estado original y desactiva el acceso root.")))

 );
  }
}
