part of '../../domain_repositories.dart';

abstract class CensoRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DataMesaResponse> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  });

  Future<List<DataPerCenso>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });

  Future<List<DataProceso>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  });

  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request});

  Future<bool> updateCoordenadasMesa({
    required UpdateCoordenadasMesaRequest request,
  });

  Future<List<DataHistoryCenso>> getDatosHistoryCensos({
    required int idPerCensado,
  });

  Future<String> downloadPdfCenso({
    required DownloadPdfCensoRequest request,
  });
}
