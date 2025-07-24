part of '../../domain_repositories.dart';



abstract class CensoRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataCensado>> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  });

  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });

  Future<List<DataCensado>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  });

  Future<bool> updateFoto({
    required UpdateFotoPerCensoRequest request,
  });




}
