part of '../../providers_impl.dart';

class BeneficiosApiProviderImpl extends BeneficiosRepository {
  @override
  Future<List<DataCatBeneficio>> getCategoriaBeneficios() async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
              '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes.DNBSO_CAT_BENEFICIO}');
      return catBeneficiosModelFromJson(json).dataCatBeneficio;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataCatBeneficio>> getCatalogoBeneficios(
      {required int idDbsCatBeneficios}) async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
              '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes.DNBSO_CATALOGO}&filter=${idDbsCatBeneficios}');
      return catBeneficiosModelFromJson(json).dataCatBeneficio;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataConvenio>> getConveniosByIdEmpresa(
      {required int idDbsEmpresa}) async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
              '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes.DNBSO_CONVENIOS}&idDbsEmpresa=${idDbsEmpresa}');
      return conveniosModelFromJson(json).dataConvenio;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
