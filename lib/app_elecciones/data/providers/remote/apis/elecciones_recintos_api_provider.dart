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
}
