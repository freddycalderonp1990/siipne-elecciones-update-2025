part of '../../providers_impl.dart';

class PersonaApiProviderImpl extends PersonaRepository {
  @override
  Future<DatosPer> getDatosPersona(
      {required String cedula, required int usuario}) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_PERSONA_BY_CEDULA,
      "cedula": cedula,
      "usuario": usuario
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
      {required int idDgoCreaOpReci,
      required int idGenPersona,
      required int usuario,
      required double latitud,
      required double longitud,
      required int idDgoReciElect,
      required int idDgoTipoEje,
      required String ip
      }) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.ELECCIONES_RECINTO_ADD_PERSONA,
      "idDgoReciElect": idDgoReciElect,
      "usuario": usuario,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idGenPersona": idGenPersona,
      "idDgoTipoEje": idDgoTipoEje
    };

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
}
