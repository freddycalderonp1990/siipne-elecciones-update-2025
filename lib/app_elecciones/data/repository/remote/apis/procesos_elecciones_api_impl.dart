part of '../../data_repositories.dart';

class ProcesosEleccionesApiImpl extends ProcesosEleccionesRepository {
  final ProcesosEleccionesApiProviderImpl _procesosEleccionesApiProviderImpl;

  ProcesosEleccionesApiImpl(this._procesosEleccionesApiProviderImpl);


  @override
  Future<List<DatosProcesoImg>> getProcesoActivoImgs() async {
    return await _procesosEleccionesApiProviderImpl.getProcesoActivoImgs();
  }
}
