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

  @override
  Future<AbrirRecintoElectoral> crearCodigo(
      {required int usuario,
      required int idGenPersona,
      required int idDgoReciElect,
      required double latitud,
      required double longitud,
      required int idDgoProcElec,
      required int idDgoReciUnidadPolicial,
      required String telefono,
      required String ip,
      required int idDgoTipoEje}) async {
    return await _EleccionesRecintosApiProviderImpl.crearCodigo(
        usuario: usuario,
        idGenPersona: idGenPersona,
        idDgoReciElect: idDgoReciElect,
        latitud: latitud,
        longitud: longitud,
        idDgoProcElec: idDgoProcElec,
        idDgoReciUnidadPolicial: idDgoReciUnidadPolicial,
        telefono: telefono,
        ip: ip,
        idDgoTipoEje: idDgoTipoEje);
  }

  @override
  Future<bool> abandonarRecintoElectoral(
      {required int idDgoPerAsigOpe,
      required int usuario,
      required double latitud,
      required double longitud,
        required int idDgoProcElec,
        required int idDgoReciElect,
      required String ip}) async {
    return await _EleccionesRecintosApiProviderImpl.abandonarRecintoElectoral(
        idDgoPerAsigOpe: idDgoPerAsigOpe,
        usuario: usuario,
        latitud: latitud,
        longitud: longitud,
        idDgoProcElec: idDgoProcElec,
        idDgoReciElect: idDgoReciElect,
        ip: ip);
  }
}
