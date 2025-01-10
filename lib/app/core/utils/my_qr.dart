import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app_elecciones/core/values/mensajes_string.dart';
import '../../../app_elecciones//presentation/widgets/customWidgets.dart';
import '../../presentation/widgets/custom_app_widgets.dart';

class MyQr{


  static Future<bool> _checkPermisoStatus() async {
    final status = await Permission.camera.request();



    bool result = false;
    switch (status) {
      case PermissionStatus.granted:

        result = true;

        break;

      case PermissionStatus.provisional:
      // GPS está activo verifica si el gps del dispositivo se encuentra activo

        result = true;

        break;

      case PermissionStatus.limited:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
      //permisos denegas por completo
      //Redirecciona al usuario para que de manuera manual asigne los permisos
        result = await openAppSettings();
    }

    print("respuesta del permiso esssss 0001 ${result}");

    return result;
  }
}