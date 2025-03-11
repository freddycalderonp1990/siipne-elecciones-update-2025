part of '../../data_repositories.dart';

class EleccionesNovedadesApiImpl extends EleccionesNovedadesRepository {
  final EleccionesNovedadesApiProviderImpl _eleccionesNovedadesApiProviderImpl;

  EleccionesNovedadesApiImpl(this._eleccionesNovedadesApiProviderImpl);

  @override
  Future<List<NovedadesElectorale>> getNovedadesHijas(
      {required int idDgoTipoEje,
      required int idNovedadesPadre,
      required int idDgoProcElec,
      required int idDgoReciElect}) async {
    return await _eleccionesNovedadesApiProviderImpl.getNovedadesHijas(
        idDgoProcElec: idDgoProcElec,
        idDgoReciElect: idDgoReciElect,
        idDgoTipoEje: idDgoTipoEje,
        idNovedadesPadre: idNovedadesPadre);
  }

  @override
  Future<List<NovedadesElectorale>> getNovedadesPadres({
    required int idDgoTipoEje,
    required int idDgoProcElec,
    required int idDgoReciElect,
  }) async {
    return await _eleccionesNovedadesApiProviderImpl.getNovedadesPadres(
        idDgoProcElec: idDgoProcElec,
        idDgoReciElect: idDgoReciElect,
        idDgoTipoEje: idDgoTipoEje);
  }

  @override
  Future<String> registrarNovedadesElectorales(
      {required AddNovedadesRequest request}) async {
    return await _eleccionesNovedadesApiProviderImpl
        .registrarNovedadesElectorales(request: request);
  }

  @override
  Future<List<NovedadesElectoralesDetalle>> getDetalleNovedadesPorRecinto(
      {required GetNovedadesRegistradasdRequest request}) async {
    return await _eleccionesNovedadesApiProviderImpl
        .getDetalleNovedadesPorRecinto(request: request);
  }
}
