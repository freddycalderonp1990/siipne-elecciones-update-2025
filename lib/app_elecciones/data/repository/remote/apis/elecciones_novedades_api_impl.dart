part of '../../data_repositories.dart';

class EleccionesNovedadesApiImpl extends EleccionesNovedadesRepository {
  final EleccionesNovedadesApiProviderImpl _eleccionesNovedadesApiProviderImpl;

  EleccionesNovedadesApiImpl(this._eleccionesNovedadesApiProviderImpl);

  @override
  Future<List<NovedadesElectorale>> getNovedadesHijas(
      {required GetNovedadesHijasRequest request}) async {
    return await _eleccionesNovedadesApiProviderImpl.getNovedadesHijas(
       request: request);
  }

  @override
  Future<List<NovedadesElectorale>> getNovedadesPadres({
    required GetNovedadesPadresRequest request,

  }) async {
    return await _eleccionesNovedadesApiProviderImpl.getNovedadesPadres(
        request: request);
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
