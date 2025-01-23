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
  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos(
      {required double latitud,
      required double longitud,
      required int idDgoProcElec,
      required int idDgoTipoEje}) async {
    return await _EleccionesRecintosApiProviderImpl
        .getRecintosElectoralesCercanos(
            latitud: latitud,
            longitud: longitud,
            idDgoProcElec: idDgoProcElec,
            idDgoTipoEje: idDgoTipoEje);
  }
}
