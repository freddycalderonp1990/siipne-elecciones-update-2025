part of '../../domain_repositories.dart';

abstract class EleccionesNovedadesRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<NovedadesElectorale>> getNovedadesPadres({
    required GetNovedadesPadresRequest request,
  });

  Future<List<NovedadesElectorale>> getNovedadesHijas(
      {required GetNovedadesHijasRequest request});

  //esta no devuelve un true ni false xq muestra los mensajes
  //varExiste = rYa existe una novedad registrada con este documento
  //varTrue = Registro de Novedad con éxito
  // otros: No se pudo Registrar la Novedad. Vuelva a intentar o contacte con el administrador del sistema.
  Future<String> registrarNovedadesElectorales(
      {required AddNovedadesRequest request});

  Future<List<NovedadesElectoralesDetalle>> getDetalleNovedadesPorRecinto({
    required GetNovedadesRegistradasdRequest request,
  });

}
