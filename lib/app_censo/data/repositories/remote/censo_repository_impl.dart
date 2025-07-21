part of '../censo_data_repositories.dart';

class CensoRepositoryImpl extends CensoRepository {
  final CensoRemoteDataSource censoRemoteDataSource;

  CensoRepositoryImpl({required this.censoRemoteDataSource});

  @override
  Future<DataCensado> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  }) async {
    return this.censoRemoteDataSource.getDatosPersonaCenso(request: request);
  }
}
