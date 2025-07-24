part of '../../censo_datasource_impl.dart';

abstract class CensoRemoteDataSource {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataCensado>> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  });

  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });

  Future<List<DataCensado>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  });

  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request});
}

class CensoRemoteDataSourceImpl implements CensoRemoteDataSource {
  @override
  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  }) async {
    Map<String, dynamic> body =
        HeadAppCensoRequest(
          uri: CensoApiConstantes.CENSO_DATA_PER_CENSO,
          bodyRequest: request.toJson(),
        ).toJson();

    String json = await UrlApiProviderAppCenso.post(body: body);

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      // Parsear y retornar el modelo correspondiente
      return censadoModelFromJson(json).dataCensado;
    });
  }

  @override
  Future<List<DataCensado>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  }) async {
    Map<String, dynamic> body =
        HeadAppCensoRequest(
          uri: CensoApiConstantes.CENSO_PROCESOS_ACTIVOS_BY_CENSADO,
          bodyRequest: request.toJson(),
        ).toJson();
    String json = await UrlApiProviderAppCenso.post(body: body);

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      // Parsear y retornar el modelo correspondiente
      return censadoModelFromJson(json).dataCensado;
    });
  }

  @override
  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request}) async {
    Map<String, dynamic> body =
        HeadAppCensoRequest(
          uri: CensoApiConstantes.CENSO_UPDATE_FOTO_PER_CENSO,
          bodyRequest: request.toJson(),
        ).toJson();
    String json = await UrlApiProviderAppCenso.patch(body: body);

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      // Parsear y retornar el modelo correspondiente
      final responseData = jsonDecode(json);
      bool resultado = responseData['data'] == true;
      return resultado;
    });
  }

  @override
  Future<List<DataCensado>> getMesasByIdUsuario({required GetMesasByIdusuarioRequest request}) async {

      Map<String, dynamic> body =
      HeadAppCensoRequest(
        uri: CensoApiConstantes.CENSO_GET_MESAS_BY_IDUSER,
        bodyRequest: request.toJson(),
      ).toJson();
      String json = await UrlApiProviderAppCenso.post(body: body);

      return await ExceptionHelper.manejarErroresParseJsonException(() async {
        // Parsear y retornar el modelo correspondiente
        return censadoModelFromJson(json).dataCensado;
      });
  }
}
