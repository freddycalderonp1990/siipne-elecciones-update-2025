import 'package:siipnelecciones3/app/core/app_config.dart';

import '../../../app_elecciones/domain/enums/enums.dart';
import 'exceptions.dart';

class ExceptionHelper {
  static captureError(Object e) {



    if (e is ServerException) {


      //validacion para activar los mocks en caso de que no puedan ingresar al ambniente de pruebas
    if (e.cause.contains("Timeout") && AppConfig.AmbienteUrl==Ambiente.prueba) {
      if(AppConfig.isUserGoogleOrIos) {
        AppConfig.activarMocks=true;
        AppConfig.secondsTimeout=1;
      }
    }


      throw ServerException(cause: e.cause);
    } else {

      throw ServerException.msj(e.toString());
    }

  }



  static String getError(Object e) {
    if (e is ServerException) {
      throw ServerException(cause: e.cause);
    } else {
      throw ServerException.msj(e.toString());
    }

  }
}
