part of '../../providers_impl.dart';

class EleccionesNovedadesApiProviderImpl extends EleccionesNovedadesRepository {
  @override
  Future<List<NovedadesElectorale>> getNovedadesHijas({
    required  GetNovedadesHijasRequest request
  }) async {

    Map<String, dynamic> body = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_GET_NOVEDADES_BY_ID_PADRE,
        bodyRequest: request.toJson())
        .toJson();

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "novedadesElectorales";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return novedadesElectoralesModelFromJson(datosJson)
            .novedadesElectorales;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return [];
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<List<NovedadesElectorale>> getNovedadesPadres({
    required  GetNovedadesPadresRequest request
  }) async {

    Map<String, dynamic> body = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_GET_NOVEDADES_PADRES,
        bodyRequest: request.toJson())
        .toJson();

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "novedadesElectorales";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return novedadesElectoralesModelFromJson(datosJson)
            .novedadesElectorales;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return [];
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<String> registrarNovedadesElectorales(
      {required AddNovedadesRequest request}) async {
    HeadEleccionesRequest _headEleccionesRequest = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_NOVEDADES_INSERT,
        bodyRequest: request.toJson());

    String json = await UrlApiProviderSiipneMovil.post(
      body: _headEleccionesRequest.toJson(),
    );

    String titleJson = "insertNovedadesElectorales";

    try {
      // Validar la respuesta del servidor
      String msj =
          await ResponseApi.validateInsert(json: json, titleJson: titleJson);

      // En caso de respuesta no válida, devolver un modelo vacío
      return msj;
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<List<NovedadesElectoralesDetalle>> getDetalleNovedadesPorRecinto(
      {required GetNovedadesRegistradasdRequest request}) async {
    HeadEleccionesRequest _headEleccionesRequest = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_GET_ALL_NOVEDADES,
        bodyRequest: request.toJson());

    String json = await UrlApiProviderSiipneMovil.post(
      body: _headEleccionesRequest.toJson(),
    );

    String titleJson = "novedadesElectoralesDetalle";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente

        return novedadesElectoralesDetalleModelFromJson(datosJson)
            .novedadesElectoralesDetalle;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return [];
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }
}
