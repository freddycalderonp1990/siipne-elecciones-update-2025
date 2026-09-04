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

