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
}
