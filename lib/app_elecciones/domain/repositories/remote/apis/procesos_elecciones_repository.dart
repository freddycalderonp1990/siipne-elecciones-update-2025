

part of '../../domain_repositories.dart';



abstract class ProcesosEleccionesRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DatosProcesoImg>> getProcesoActivoImgs() ;


}