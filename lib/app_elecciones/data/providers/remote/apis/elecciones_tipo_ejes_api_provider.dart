part of '../../providers_impl.dart';

class EleccionesTipoEjesApiProviderImpl extends EleccionesTipoEjesRepository {


  @override
  Future<TipoEjesActivos> getTipoEjesActivosEnProcesoOperativos(
      {required int usuario, required int idDgoProcElec}) async {
    // TODO: implement getTipoEjesActivosEnProcesoOperativos
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_SERVICIOS_ACTIVOS,
      "idDgoProcElec":idDgoProcElec,
      "usuario":usuario
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "tipoEjesActivos";

    try {
      // Validar la respuesta del servidor
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return tipoEjesActivosModelFromJson(datosJson).tipoEjesActivos;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return TipoEjesActivos.empty();
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }
}
