part of '../../data_repositories.dart';

class EleccionesTipoEjesApiImpl extends EleccionesTipoEjesRepository {
  final EleccionesTipoEjesApiProviderImpl _eleccionesTipoEjesApiProviderImpl;

  EleccionesTipoEjesApiImpl(this._eleccionesTipoEjesApiProviderImpl);

  @override
  Future<TipoEjesActivos> getTipoEjesActivosEnProcesoOperativos(
      {required int usuario, required int idDgoProcElec}) async {
    return await _eleccionesTipoEjesApiProviderImpl
        .getTipoEjesActivosEnProcesoOperativos(
            usuario: usuario, idDgoProcElec: idDgoProcElec);
  }

  @override
  Future<List<UnidadesPoliciale>> getUnidadesPoliciales(
      {required int usuario}) async {
    return await _eleccionesTipoEjesApiProviderImpl.getUnidadesPoliciales(
        usuario: usuario);
  }

  @override
  Future<List<UnidadesPoliciale>> getTipoEjePorIdPadre(
      {required int usuario, required int idDgoTipoEje}) async {
    return await _eleccionesTipoEjesApiProviderImpl.getTipoEjePorIdPadre(
        usuario: usuario, idDgoTipoEje: idDgoTipoEje);
  }

  @override
  Future<List<DatosUnidadesId>> getUnidadesPolicialesById(
      {required int idDgoTipoEje}) async {
    return await _eleccionesTipoEjesApiProviderImpl.getUnidadesPolicialesById(
        idDgoTipoEje: idDgoTipoEje);
  }
}
