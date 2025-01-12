part of '../../data_repositories.dart';

class EleccionesProcesosApiImpl extends EleccionesProcesosRepository {
  final EleccionesProcesosApiProviderImpl _EleccionesProcesosApiProviderImpl;

  EleccionesProcesosApiImpl(this._EleccionesProcesosApiProviderImpl);


  @override
  Future<List<DatosProcesoImg>> getProcesoActivoImgs() async {
    return await _EleccionesProcesosApiProviderImpl.getProcesoActivoImgs();
  }
}
