import '../../../app_elecciones//domain/enums/enums.dart';
import '../../core/app_config.dart';

abstract class Failure implements Exception {
  final String message;

  Failure({
    required this.message,
  });

  get msj=>message;


}


class  UpdateApp implements Exception {
  final String message;

  UpdateApp({
    required this.message,
  });

  get msj=>message;

}

class  ParseJsonException implements Exception {
  final String message;

  ParseJsonException({
    required this.message,
  });

  get msj=>message;

}

class ServerException implements Exception {
  final String cause;

  ServerException({ required this.cause});


  factory ServerException.msj(msjException
   ) {
    String mesage = 'No es posible conectar con el servidor. Contacte con el administrador';

    if (AppConfig.AmbienteUrl != Ambiente.produccion) {
      mesage = mesage + ' Exception: ' + msjException;
    }

    return ServerException(cause:mesage);
  }

  get msj=>cause;

  factory ServerException.StatusCode(
      {int statusCode = 0,

      String msjException = ''}) {
    String mesage = 'No definido';
    print("jajajajajaj");

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

      case 426: //HTTP_No_autorizado
        mesage = 'Actualizacion Disponible'
            '\n\nExiste una nueva versión disponible. Para continuar, es necesario que actualice la aplicación.'
            ;
        break;

      default:
        mesage = 'No  es posible conectar con el servidor.'
            '\n\nPor favor revise su conexión a internet y vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;
    }

    if (AppConfig.AmbienteUrl != Ambiente.produccion) {
      mesage = mesage + '\n\nException: ' + msjException;
    }


    return ServerException(cause:mesage);
  }
}




class  TimeoutException implements Exception {
  final String e;

  TimeoutException(
    this.e,
  );

  get msj=>e;


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