part of '../../providers_impl.dart';

class PersonaApiProviderImpl extends PersonaRepository {
  @override
  Future<DatosPer> getDatosPersona(
      {required String cedula, required int usuario, int? idDgoProcElec}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_PERSONA_BY_CEDULA,
      "cedula": cedula,
      "usuario": usuario,
      "idDgoProcElec": idDgoProcElec==null?0:idDgoProcElec
    };



    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "dataPersona";
    DatosPer dataPerson = DatosPer.empty();

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        List<DatosPer> datosPers = datosPersModelFromJson(datosJson).datosPers;
        if (datosPers.length > 0) {
          dataPerson = datosPers[0];
        }
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return dataPerson;
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral(
      {  required AddPersonalRequest request}) async {

    Map<String, dynamic> body = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_RECINTO_ADD_PERSONA,
        bodyRequest: request.toJson())
        .toJson();

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "resgistroPersEnRecElectoral";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return resgistroPersEnRecElectoralModelFromJson(datosJson)
            .resgistroPersEnRecElectoral;
      }
      // En caso de respuesta no válida, devolver un modelo vacío
      return ResgistroPersEnRecElectoral.empty();
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }

  @override
  Future<List<PersonalRecintoElectoral>>
      consultarDatosPersonalAsignadoRecintoElectoral(
          {required int idDgoCreaOpReci,
          required int idDgoProcElec,
          required int idDgoReciElect}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_RECINTO_GET_PERSONAL,
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
    };

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    String titleJson = "personalRecintoElectoral";

    try {
      // Validar la respuesta del servidor
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      // Si la respuesta es válida
      if (msj == ApiConstantes.varTrue) {
        // Obtener los datos del modelo en formato String
        String datosJson = getDatosModelFromString(json, titleJson);
        // Parsear y retornar el modelo correspondiente
        return personalRecintoElectoralModelFromJson(datosJson)
            .personalRecintoElectoral;
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
  Future<PerSituacion> verificarSiPersonaEstaBloqueado(
      {required int idDgoProcElec, required int idGenPersona}) async{
    Map<String, dynamic> request = {
      "idDgoProcElec": idDgoProcElec,
      "idGenPersona": idGenPersona};

    Map<String, dynamic> body = HeadEleccionesRequest(
        uri: ApiConstantes.ELECCIONES_RECINTO_PER_VER_SITUACION,
        bodyRequest: request)
        .toJson();

    String json = await UrlApiProviderSiipneMovil.post(
      body: body,
    );

    try {
      final List<PerSituacion> perSituacion= perSituacionModelFromJson(json).perSituacion;
      if(perSituacion.length>0){
        return perSituacion[0];
      }
      return PerSituacion.empty();
    } catch (e, stackTrace) {
      // Manejo centralizado de excepciones
      throw ParseJsonException(
          message: "Problema en Parse Model: ${e} - stackTrace: ${stackTrace}");
    }
  }
}
