part of '../../providers_impl.dart';

class EleccionesProcesosApiProviderImpl extends EleccionesProcesosRepository {
  @override
  Future<List<DatosProcesoImg>> getProcesoActivoImgs() async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_PROCESOS_ACTIVOS_IMG,
    };

    String json = await UrlApiProviderSiipneMovil.post(
      isLogin: true,
      body: body,
    );

    try {
      return procesosImgModelFromJson(json)
          .procesosOperativosActivos
          .datosProcesoImg;
    } catch (e, stackTrace) {
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<List<ProcesosOperativo>> getProcesosOperativos(
      {required double latitud, required double longitud}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_PROCESOS_ACTIVOS,
      "latitud":latitud,
      "longitud":longitud
    };

    String json = await UrlApiProviderSiipneMovil.post(
      isLogin: true,
      body: body,
    );

    String titleJson = "procesosOperativos";

    try {
      // Validar la respuesta del servidor
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return  procesosOperativosModelFromJson(datosJson).procesosOperativos;
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
