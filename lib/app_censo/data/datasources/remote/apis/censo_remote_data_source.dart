part of '../../censo_datasource_impl.dart';

abstract class CensoRemoteDataSource {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DataCensado> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });
}

class CensoRemoteDataSourceImpl implements CensoRemoteDataSource {
  @override
  Future<DataCensado> getDatosPersonaCenso({
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
}
