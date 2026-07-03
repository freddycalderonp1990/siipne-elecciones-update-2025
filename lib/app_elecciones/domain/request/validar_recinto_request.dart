part of 'request.dart';

enum TipoValidacionRecinto {
  movilAndroid,
  movilIos,
  web
}

extension TipoValidacionRecintoExtension on TipoValidacionRecinto {
  //  tipoValidacion=  ENUM('WEB', 'MóVIL-ANDROID', 'MóVIL-IOS', 'EN PROCESO')
  String get valor {
    switch (this) {
      case TipoValidacionRecinto.movilAndroid:
        return 'MÓVIL-ANDROID';
      case TipoValidacionRecinto.movilIos:
        return 'MÓVIL-IOS';
      case TipoValidacionRecinto.web:
        return 'WEB';
    }
  }
}

class ValidarRecintoRequest {
  final int idDgoComisios;
  final double latitudValidacion;
  final double longitudValidacion;
  final String telefono;
  final TipoValidacionRecinto tipoValidacion;

  final int usuario;
  final String ip;




ValidarRecintoRequest(
    {
      required this.latitudValidacion,
      required this.longitudValidacion,
      required this.idDgoComisios,
      required this.telefono,
      required this.tipoValidacion,

      required this.usuario,
      required this.ip,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoComisios": idDgoComisios,
      "latitudValidacion": latitudValidacion,
      "longitudValidacion": longitudValidacion,
      "telefono": telefono,
      "usuario": usuario,
      "ip": ip,
      "tipoValidacion": tipoValidacion.valor

    };
  }
}
