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
}
