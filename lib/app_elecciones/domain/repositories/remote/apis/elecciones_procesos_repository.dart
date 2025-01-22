part of '../../domain_repositories.dart';

abstract class EleccionesProcesosRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DatosProcesoImg>> getProcesoActivoImgs();

  Future<List<ProcesosOperativo>> getProcesosOperativos(
      {required double latitud, required double longitud});
}
