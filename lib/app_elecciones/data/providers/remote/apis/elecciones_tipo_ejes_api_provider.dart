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

  @override
  Future<List<UnidadesPoliciale>> getUnidadesPoliciales({required int usuario}) async {


      Object? body = {
        "modulo": ApiConstantes.MODULO,
        "uri": ApiConstantes.ELECCIONES_UNIDADES_POLICIALES,
        "usuario":usuario
      };

      String json = await UrlApiProviderSiipneMovil.post(
        body: body,
      );

      String titleJson = "unidadesPoliciales";

      try {
        // Validar la respuesta del servidor
        String msj =
        ResponseApi.validateConsultas(json: json, titleJson: titleJson);
        // Si la respuesta es válida
        if (msj == ApiConstantes.varTrue) {
          // Obtener los datos del modelo en formato String
          String datosJson = getDatosModelFromString(json, titleJson);
          // Parsear y retornar el modelo correspondiente
          return unidadesPolicialesModelFromJson(datosJson).unidadesPoliciales;
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
  Future<List<UnidadesPoliciale>> getTipoEjePorIdPadre({required int usuario, required int idDgoTipoEje}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_TIPOS_EJES_BY_ID_PADRE,
      "usuario":usuario,
      "idDgoTipoEje": idDgoTipoEje,
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "unidadesPoliciales";

    try {
      // Validar la respuesta del servidor
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return unidadesPolicialesModelFromJson(datosJson).unidadesPoliciales;
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
