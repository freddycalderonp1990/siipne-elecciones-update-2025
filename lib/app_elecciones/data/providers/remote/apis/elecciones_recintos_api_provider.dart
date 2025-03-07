part of '../../providers_impl.dart';

class EleccionesRecintosApiProviderImpl extends EleccionesRecintosRepository {
  @override
  Future<RecintosElectoralesAbiertos> verificarperAsignadoRecElectoral(
      {required int idGenPersona}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_VERIFICA_PER_ASIGNADO_REC_ELECT,
      "idGenPersona": idGenPersona
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "recintosElectoralesAbiertos";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return recintosElectoralesAbiertosModelFromJson(datosJson)
            .recintosElectoralesAbiertos;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return RecintosElectoralesAbiertos.empty();
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos({
    required double latitud,
    required double longitud,
    required int idDgoProcElec,
    required int idDgoTipoEje,
  }) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_RECINTOS_ELECTORALES,
      "latitud": latitud,
      "longitud": longitud,
      "idDgoProcElec": idDgoProcElec,
      "idDgoTipoEje": idDgoTipoEje
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "recintosElectorales";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return RecintosElectoralsModelFromJson(datosJson).RecintosElectorals;
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
  Future<AbrirRecintoElectoral> crearCodigo(
      {required int usuario,
      required int idGenPersona,
      required int idDgoReciElect,
      required double latitud,
      required double longitud,
      required int idDgoProcElec,
      required int idDgoReciUnidadPolicial,
      required String telefono,
      required String ip,
      required int idDgoTipoEje}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_CREAR_CODIGO,
      "idDgoReciElect": idDgoReciElect,
      "usuario": usuario,
      "idGenPersona": idGenPersona,
      "idDgoProcElec": idDgoProcElec,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "idDgoReciUnidadPolicial": idDgoReciUnidadPolicial,
      "telefono": telefono,
      "idDgoTipoEje": idDgoTipoEje
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "AbrirRecintoElectoral";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return abrirRecintoElectoralModelFromJson(datosJson)
            .abrirRecintoElectoral;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return AbrirRecintoElectoral.empty();
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<bool> abandonarRecintoElectoral(
      {required int idDgoPerAsigOpe,
      required int usuario,
      required double latitud,
      required double longitud,
        required int idDgoProcElec,
        required int idDgoReciElect,
        required String ip}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_RECINTO_ABANDONAR_PERSONAL,
      "idDgoPerAsigOpe": idDgoPerAsigOpe,
      "usuario": usuario,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect
    };
    String json = await UrlApiProviderSiipneMovil.put(
      body: body,
    );

    String titleJson = "abandonarRecintoElectoral";

    try {
      // Validar la respuesta del servidor
      String msj =
      await ResponseApi.validateInsert(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        return true;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return false;
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }
}
