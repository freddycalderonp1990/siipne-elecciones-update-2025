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
  Future<List<DataCensado>> getDatosProcesosActivosByCensado({required GetDatosProcesosActivosRequest request}) async{
    return this.censoRemoteDataSource.getDatosProcesosActivosByCensado(request: request);
  }

  @override
  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request}) async {
    return this.censoRemoteDataSource.updateFoto(request: request);
  }

  @override
  Future<List<DataCensado>> getMesasByIdUsuario({required GetMesasByIdusuarioRequest request}) async {
    return this.censoRemoteDataSource.getMesasByIdUsuario(request: request);
  }
}
