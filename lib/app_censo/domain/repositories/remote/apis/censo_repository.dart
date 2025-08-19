part of '../../domain_repositories.dart';



abstract class CensoRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataMesa>> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  });

  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });

  Future<List<DataProceso>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  });



  Future<bool> updateFoto({
    required UpdateFotoPerCensoRequest request,
  });

  Future<bool> updateCoordenadasMesa({
    required UpdateCoordenadasMesaRequest request,
  });

  Future<List<DataHistoryCenso>> getDatosHistoryCensos({
    required int idPerCensado,
  });



}
