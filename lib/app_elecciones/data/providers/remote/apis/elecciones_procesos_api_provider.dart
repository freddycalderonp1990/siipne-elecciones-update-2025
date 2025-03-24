part of '../../providers_impl.dart';

class EleccionesProcesosApiProviderImpl extends EleccionesProcesosRepository {
  @override
  Future<List<DatosProcesoImg>> getProcesoActivoImgs() async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_PROCESOS_ACTIVOS_IMG,
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return procesosImgModelFromJson(json)
          .procesosOperativosActivos
          .datosProcesoImg;
    });
  }

  @override
  Future<List<ProcesosOperativo>> getProcesosOperativos(
      {required double latitud, required double longitud}) async {

    Map<String, dynamic> request={
      "latitud":latitud,
      "longitud":longitud
    };

    Map<String, dynamic> body = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_PROCESOS_ACTIVOS,
        bodyRequest: request)
        .toJson();

    String json = await UrlApiProviderSiipneMovil.post(

      body: body,
    );

    String titleJson = "procesosOperativos";

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      // Validar la respuesta del servidor
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return procesosOperativosModelFromJson(datosJson).procesosOperativos;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return [];
    });
  }
}
