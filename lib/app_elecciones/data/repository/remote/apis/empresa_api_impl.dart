part of '../../data_repositories.dart';

class EmpresaApiImpl extends EmpresaRepository {
  final EmpresaApiProviderImpl _empresaApiProviderImpl;

  EmpresaApiImpl(this._empresaApiProviderImpl);

  @override
  Future<List<DataEmpresa>> getEmpresasbyIdCatalogo({required int id}) async {
    try {
      return await _empresaApiProviderImpl.getEmpresasbyIdCatalogo(id: id);
    } catch (e) {

      if (AppConfig.activarMocks) {
        try {
          final json =
          await rootBundle.rootBundle.loadString(AppMocks.empresas);
          return empresaModelFromJson(json).dataEmpresa;
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataBanner>> getAllBanners({required int limit}) async {
    try {
      return await _empresaApiProviderImpl.getAllBanners(limit:limit);
    } catch (e) {
      if (AppConfig.activarMocks) {
        try {
          final json =
          await rootBundle.rootBundle.loadString(AppMocks.banners);
          return bannersModelFromJson(json).dataBanners;
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataSucursale>> getSucursalesByIdEmpresa(
      {required int idDbsEmpresa,
      required double latitud,
      required double longitud}) async {
    try {
      return await _empresaApiProviderImpl.getSucursalesByIdEmpresa(
          idDbsEmpresa: idDbsEmpresa, latitud: latitud, longitud: longitud);
    } catch (e) {
      if (AppConfig.activarMocks) {
        try {

          return [];
        } catch (e) {
          throw ExceptionHelper.captureError(e);
        }
      }
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<DataPdf> getPdfConvenios({required String nameFile}) async{
    try {
      return await _empresaApiProviderImpl.getPdfConvenios(nameFile: nameFile);
    } catch (e) {
      try {
        final json =
        await rootBundle.rootBundle.loadString(AppMocks.doc_pdf);
        return pdfConveniosModelFromJson(json).dataPdf;
      } catch (e) {
        throw ExceptionHelper.captureError(e);
      }
      throw ExceptionHelper.captureError(e);
    }
  }
}
