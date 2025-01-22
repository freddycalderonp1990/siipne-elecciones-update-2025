part of '../../data_repositories.dart';

class EleccionesProcesosApiImpl extends EleccionesProcesosRepository {
  final EleccionesProcesosApiProviderImpl _EleccionesProcesosApiProviderImpl;

  EleccionesProcesosApiImpl(this._EleccionesProcesosApiProviderImpl);

  @override
  Future<List<DatosProcesoImg>> getProcesoActivoImgs() async {
    return await _EleccionesProcesosApiProviderImpl.getProcesoActivoImgs();
  }

  @override
  Future<List<ProcesosOperativo>> getProcesosOperativos(
      {required double latitud, required double longitud}) async {
    return await _EleccionesProcesosApiProviderImpl.getProcesosOperativos(
        latitud: latitud, longitud: longitud);
  }
}
