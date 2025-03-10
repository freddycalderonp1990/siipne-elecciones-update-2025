part of '../../data_repositories.dart';

class EleccionesRecintosApiImpl extends EleccionesRecintosRepository {
  final EleccionesRecintosApiProviderImpl _EleccionesRecintosApiProviderImpl;

  EleccionesRecintosApiImpl(this._EleccionesRecintosApiProviderImpl);

  @override
  Future<RecintosElectoralesAbiertos> verificarperAsignadoRecElectoral(
      {required int idGenPersona}) async {
    return await _EleccionesRecintosApiProviderImpl
        .verificarperAsignadoRecElectoral(idGenPersona: idGenPersona);
  }

  @override
  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos({
    required RecintoCercanosRequest request,
  }) async {
    return await _EleccionesRecintosApiProviderImpl
        .getRecintosElectoralesCercanos(request: request);
  }

  @override
  Future<AbrirRecintoElectoral> crearCodigo(
      {required CreateCodeRecintoRequest request}) async {
    return await _EleccionesRecintosApiProviderImpl.crearCodigo(
        request: request);
  }

  @override
  Future<bool> abandonarRecintoElectoral({
    required AbandonarRecintoRequest request,
  }) async {
    return await _EleccionesRecintosApiProviderImpl.abandonarRecintoElectoral(
        request: request);
  }

  @override
  Future<String> eliminarRecintoElectoralAbierto(
      {required EliminarRecintoRequest request}) async {
    return await _EleccionesRecintosApiProviderImpl.eliminarRecintoElectoralAbierto(
        request: request);
  }
}
