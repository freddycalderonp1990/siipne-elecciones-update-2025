import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:siipnelecciones3/app/core/app_config.dart';

import '../../../app_elecciones/core/siipne_config.dart';
import '../../../app_elecciones/core/values/mensajes_string.dart';
import '../../../app_elecciones/domain/enums/enums.dart';
import '../../../app_elecciones/presentation/widgets/customWidgets.dart';
import '../utils/utilidadesUtil.dart';
import 'exceptions.dart';

class ExceptionHelper {

  static Future<bool> manejarErrores(Future<void> Function() funcion) async {
    try {
      await funcion();
      return true; // Operación exitosa
    } on UpdateAppException catch (e) {
      mensajeActualizarApp();
    } on ServerException catch (e) {
      DialogosAwesome.getError(descripcion: e.message);
    } on ParseJsonException catch (e) {
      DialogosAwesome.getError(descripcion: e.message);
    } catch (e,t) {
      String msj= ExceptionHelper.setMensaje(
          mensaje: "Error Inesperado",
          msjException: "Error: ${e} - Linea: ${t}");

      DialogosAwesome.getError(descripcion: msj);
    }
    return false; // Hubo un error
  }

 static mensajeActualizarApp() {
    DialogosAwesome.getWarning(
        title: "ACTUALIZAR LA APP",
        descripcion: MensajesString.msjNuevaVersionApp,
        btnOkOnPress: () {
          Get.back();
          if (GetPlatform.isAndroid) {
            UtilidadesUtil.abrirUrl(SiipneConfig.linkAppAndroid);
            print('App Android');
          } else {
            UtilidadesUtil.abrirUrl(SiipneConfig.linkAppIos);
            print('App Ios');
          }
        });
  }





  static captureError(Object e,Object stackTrace ) {
    if (e is ServerException) {
      //validacion para activar los mocks en caso de que no puedan ingresar al ambniente de pruebas
      if (e.message.contains("Timeout") &&
          AppConfig.AmbienteUrl.toString() == Ambiente.prueba.toString()) {
        if (AppConfig.isUserGoogleOrIos) {
          AppConfig.activarMocks = true;
          AppConfig.secondsTimeout = 1;
        }
      }

      throw ServerException(message: e.message);
    } else {
      String msj = ExceptionHelper.setMensaje(msjException: e.toString());
      throw ServerException(message: msj);
    }
  }

  //lo que este en mensaje siempre se va a mostra
  //msjException solo se muestra si el ambiente es difrente de produccion
  static String setMensaje(
      {String mensaje =
          "Ocurrió un problema. Intente nuevamente o contacte al administrador.",
      required String msjException}) {
    if (AppConfig.AmbienteUrl.toString() != Ambiente.produccion.toString()) {
      mensaje = mensaje + ' Exception: ' + msjException;
    }
    return mensaje;
  }


}
