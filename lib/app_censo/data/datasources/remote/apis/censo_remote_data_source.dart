part of '../../censo_datasource_impl.dart';

abstract class CensoRemoteDataSource {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataMesa>> getMesasByIdUsuario({
    required GetMesasByIdusuarioRequest request,
  });

  Future<List<DataCensado>> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });

  Future<List<DataProceso>> getDatosProcesosActivosByCensado({
    required GetDatosProcesosActivosRequest request,
  });

  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request});

  Future<bool> updateCoordenadasMesa({
    required UpdateCoordenadasMesaRequest request,
  });

  Future<List<DataHistoryCenso>> getDatosHistoryCensos({
    required int idPerCensado,
  });
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
  Future<List<DataProceso>> getDatosProcesosActivosByCensado({
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
      return procesoModelFromJson(json).dataProceso;
    });
  }

  @override
  Future<bool> updateFoto({required UpdateFotoPerCensoRequest request}) async {
    Map<String, dynamic> body =
        HeadAppCensoRequest(
          uri: CensoApiConstantes.CENSO_REGISTRE,
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
  Future<List<DataMesa>> getMesasByIdUsuario({required GetMesasByIdusuarioRequest request}) async {

      Map<String, dynamic> body =
      HeadAppCensoRequest(
        uri: CensoApiConstantes.CENSO_GET_MESAS_BY_IDUSER,
        bodyRequest: request.toJson(),
      ).toJson();
      String json = await UrlApiProviderAppCenso.post(body: body);

      return await ExceptionHelper.manejarErroresParseJsonException(() async {
        // Parsear y retornar el modelo correspondiente
        return mesasModelFromJson(json).dataMesa;
      });
  }

  @override
  Future<bool> updateCoordenadasMesa({required UpdateCoordenadasMesaRequest request})  async{
    Map<String, dynamic> body =
    HeadAppCensoRequest(
      uri: CensoApiConstantes.MESA_UPDATE_COORDENADAS,
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
  Future<List<DataHistoryCenso>> getDatosHistoryCensos({required int idPerCensado}) async {
    Map<String, dynamic> body =
    HeadAppCensoRequest(
      uri: CensoApiConstantes.CENSO_HISTORIAL_BY_IDPERCENSADO,
      bodyRequest: {
        "idPerCensado": idPerCensado},
    ).toJson();
    String json = await UrlApiProviderAppCenso.post(body: body);
    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      // Parsear y retornar el modelo correspondiente
      return historyCensoModelFromJson(json).dataHistoryCenso;
    });
  }
}
