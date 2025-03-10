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
    required RecintoCercanosRequest request,
  }) async {
    Map<String, dynamic> body = HeadEleccionesRequest(
            uri: ApiConstantes.ELECCIONES_RECINTOS_ELECTORALES,
            bodyRequest: request.toJson())
        .toJson();

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
      {required CreateCodeRecintoRequest request}) async {
    Map<String, dynamic> body = HeadEleccionesRequest(
            uri: ApiConstantes.ELECCIONES_CREAR_CODIGO,
            bodyRequest: request.toJson())
        .toJson();

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
      {required AbandonarRecintoRequest request}) async {
    Map<String, dynamic> body = HeadEleccionesRequest(
            uri: ApiConstantes.ELECCIONES_RECINTO_ABANDONAR_PERSONAL,
            bodyRequest: request.toJson())
        .toJson();

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

  @override
  Future<String> eliminarRecintoElectoralAbierto(
      {required EliminarRecintoRequest request}) async{
    Map<String, dynamic> body = HeadEleccionesRequest(
            uri: ApiConstantes.ELECCIONES_RECINTO_ELIMINAR,
            bodyRequest: request.toJson())
        .toJson();

    String json = await UrlApiProviderSiipneMovil.delete(
      body: body,
    );
    String titleJson = "eliminarRecintoElectoral";

    try {
      // Validar la respuesta del servidor
      String msj =
          await ResponseApi.validateInsert(json: json, titleJson: titleJson);
      return msj;
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }
}
