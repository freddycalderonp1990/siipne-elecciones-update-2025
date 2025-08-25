part of '../censo_data_repositories.dart';

class CensoRepositoryImpl extends CensoRepository {
  final CensoRemoteDataSource censoRemoteDataSource;

  CensoRepositoryImpl({required this.censoRemoteDataSource});

  @override
  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  }) async {
    return this.censoRemoteDataSource.getDatosPersonaCenso(request: request);
  }

  @override
  Future<List<DataProceso>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  }) async {
    return this.censoRemoteDataSource.getDatosProcesosActivosByCensado(
      request: request,
    );
  }

  @override
  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request}) async {
    return this.censoRemoteDataSource.updateFoto(request: request);
  }

  @override
  Future<List<DataMesa>> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  }) async {
    return this.censoRemoteDataSource.getMesasByIdUsuario(request: request);
  }

  @override
  Future<bool> updateCoordenadasMesa({
    required UpdateCoordenadasMesaRequest request,
  }) async {
    return this.censoRemoteDataSource.updateCoordenadasMesa(request: request);
  }

  @override
  Future<List<DataHistoryCenso>> getDatosHistoryCensos({required int idPerCensado}) async {
    // TODO: implement getDatosHistoryCensos
    return this.censoRemoteDataSource.getDatosHistoryCensos(idPerCensado: idPerCensado);
  }

  @override
  Future<String> downloadPdfCenso({required DownloadPdfCensoRequest request}) async {
    return await this.censoRemoteDataSource.downloadPdfCenso(request: request);
  }
}
