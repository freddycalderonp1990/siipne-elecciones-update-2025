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
}
