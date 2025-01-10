part of '../../providers_impl.dart';

class EmpresaApiProviderImpl extends EmpresaRepository {


  @override
  Future<List<DataEmpresa>> getEmpresasbyIdCatalogo({required int id}) async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
          '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes
              .DNBSO_EMPRESAS}&id=${id}');
      return empresaModelFromJson(json).dataEmpresa;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataBanner>> getAllBanners({required int limit}) async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
          '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes
              .DNBSO_BANNERS}'
              '&limit=${limit}');
      return bannersModelFromJson(json).dataBanners;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<DataSucursale>> getSucursalesByIdEmpresa({required int idDbsEmpresa,required double latitud,
    required double longitud})async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
          '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes
              .DNBSO_SUCURSALES}'
              '&idDbsEmpresa=${idDbsEmpresa}'
              '&latitud=${latitud}'
              '&longitud=${longitud}');
      return sucursalesModelFromJson(json).dataSucursales;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<DataPdf> getPdfConvenios({required String nameFile}) async {
    try {
      String json = await UrlApiProviderSiipneMovil.get(
          segmento:
          '?modulo=${ApiConstantes.MODULO}&uri=${ApiConstantes
              .DNBSO_DOC_CONVENIO}'
              '&nameFile=${nameFile}'
              );
      return pdfConveniosModelFromJson(json).dataPdf;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
