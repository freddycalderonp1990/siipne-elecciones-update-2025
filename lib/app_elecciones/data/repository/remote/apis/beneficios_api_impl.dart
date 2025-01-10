part of '../../data_repositories.dart';

class BeneficiosApiImpl extends BeneficiosRepository {
  final BeneficiosApiProviderImpl _beneficiosApiProviderImpl;

  BeneficiosApiImpl(this._beneficiosApiProviderImpl);

  @override
  Future<List<DataCatBeneficio>> getCategoriaBeneficios() async {
    try {
      return await _beneficiosApiProviderImpl.getCategoriaBeneficios();
    } catch (e) {
      if (AppConfig.activarMocks) {
        try {
          final json =
              await rootBundle.rootBundle.loadString(AppMocks.cat_beneficios);
          return catBeneficiosModelFromJson(json).dataCatBeneficio;
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }

      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataCatBeneficio>> getCatalogoBeneficios(
      {required int idDbsCatBeneficios}) async {
    try {
      return await _beneficiosApiProviderImpl.getCatalogoBeneficios(
          idDbsCatBeneficios: idDbsCatBeneficios);
    } catch (e) {

      if (AppConfig.activarMocks) {
        try {
          final json =
          await rootBundle.rootBundle.loadString(AppMocks.catalogo);
          return catBeneficiosModelFromJson(json).dataCatBeneficio;
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }


      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataConvenio>> getConveniosByIdEmpresa(
      {required int idDbsEmpresa}) async {
    try {
      return await _beneficiosApiProviderImpl.getConveniosByIdEmpresa(
          idDbsEmpresa: idDbsEmpresa);
    } catch (e) {
      if (AppConfig.activarMocks) {
        try {
          final json =
          await rootBundle.rootBundle.loadString(AppMocks.convenios);
          return conveniosModelFromJson(json).dataConvenio;
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }
      throw ExceptionHelper.captureError(e);
    }
  }
}
