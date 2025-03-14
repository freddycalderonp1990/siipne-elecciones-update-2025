
import '../../../app_elecciones/domain/enums/enums.dart';
import '../../core/app_config.dart';
import 'exception_helper.dart';

abstract class Failure implements Exception {
  final String message;

  Failure({
    required this.message,
  });

  get msj{
    return ExceptionHelper.setMensaje(msjException: this.message);
  }


}




class  UpdateAppException implements Exception {
  final String message;

  UpdateAppException({
    required this.message,
  });

  get msj{
    String mesage = 'Actualizacion Disponible'
        '\n\nExiste una nueva versión disponible. Para continuar, es necesario que actualice la aplicación.'
    ;
    return ExceptionHelper.setMensaje(
        mensaje: mesage,
        msjException: this.message);
  }

}


class  CloseRecintoException implements Exception {
  final String message;

  CloseRecintoException({
    required this.message,
  });

  get msj{
    String mesage = 'Recinto/Unidad no se encuentra disponible'
        '\n\nIntente nuevamente o contacte al administrador.'
    ;
    return ExceptionHelper.setMensaje(
        mensaje: mesage,
        msjException: this.message);
  }

}

class  ParseJsonException implements Exception {
  final String message;

  ParseJsonException({
    required this.message,
  });

  factory ParseJsonException.setMensaje({ String mensaje='Parse Model\n\nOcurrió un problema. Intente nuevamente o contacte al administrador.',required String msjException}){
     String msj= ExceptionHelper.setMensaje(
        mensaje: mensaje,
        msjException: msjException);

    return ParseJsonException(message: msj);
  }



  get msj{
    String mensaje='Parse Model\n\n'
        "Ocurrió un problema. Intente nuevamente o contacte al administrador.";
    return ExceptionHelper.setMensaje(
        mensaje: mensaje,
        msjException: this.message);
  }

}

class ServerException implements Exception {
  final String message;

  ServerException({ required this.message});



  factory ServerException.StatusCode(
      {int statusCode = 0,
        String msjException = ''}) {

    String mesage = 'No definido';


    switch (statusCode) {
      case 404: //HTTP_NOT_FOUND
        mesage =
        "No es posible conectar con el servidor. Pagina no encontrada.";
        break;

      case 400: //HTTP_Bad_Request
        mesage = "No es posible conectar con el servidor. Solicitud incorrecta";
        break;

      case 401: //HTTP_No_autorizado
        mesage = "No es posible conectar con el servidor. Acceso no Autorizado";
        break;

      case 500: //HTTP_No_autorizado
        mesage = 'Problema con el servidor'
            '\n\nPor favor revise su conexión a internet y vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;

      case 501: //HTTP_No_autorizado
        mesage = 'Problema con el servidor'
            '\n\nProceso no completado - vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;

      case 502: //HTTP_No_autorizado
        mesage = 'Problema con el servidor'
            '\n\nCampos Incompletos - vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;

      case 405: //HTTP_No_autorizado
        mesage = 'Metodo no implementado'
            '\n\n'
            'Si el problema persiste contacte con el administrador.  ';
        break;

      case 426: //HTTP_No_autorizado
        mesage = 'Actualizacion Disponible';

        throw UpdateAppException(message: msjException);

        break;

      case 422: //HTTP_No_autorizado
        mesage = 'Recinto/Unidad no se encuentra disponible';

        throw CloseRecintoException(message: msjException);

        break;

      default:
        mesage = 'No  es posible conectar con el servidor.'
            '\n\nPor favor revise su conexión a internet y vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;
    }



    if (AppConfig.AmbienteUrl.toString() != Ambiente.produccion.toString()) {
      mesage = mesage + '\n\nException: ' + msjException;
      print("aaaaaaa222 ${mesage}");
      print(AppConfig.AmbienteUrl);
      print(Ambiente.produccion);
    }

    print("aaaaaaa ${mesage}");
    print("aaaaaaa ${AppConfig.AmbienteUrl}");

    return ServerException(message:mesage);
  }
}






class CacheException implements Exception {}

class QRException implements Exception {

  final String cause;

  QRException({ required this.cause});


  factory QRException.msj(msjException) {
    String mesage = '';

    //if (AppConfig.AmbienteUrl != Ambiente.produccion) {
    mesage = mesage + ' QR: ' + msjException;
    //}

    return QRException(cause: mesage);
  }
}


class ConectionException implements Exception {
  final String cause;

  ConectionException({ required this.cause});


  factory ConectionException.msj(msjException
      ) {
    String mesage = 'No existe conexión';

    if (AppConfig.AmbienteUrl != Ambiente.produccion) {
      mesage = mesage + ' Exception: ' + msjException;
    }

    return ConectionException(cause:mesage);
  }


}