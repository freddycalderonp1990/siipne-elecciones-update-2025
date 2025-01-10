part of '../../domain_repositories.dart';

abstract class EmpresaRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataEmpresa>> getEmpresasbyIdCatalogo({required int id});

  Future<List<DataBanner>> getAllBanners({required int limit});

  Future<List<DataSucursale>> getSucursalesByIdEmpresa(
      {required int idDbsEmpresa,
      required double latitud,
      required double longitud});


  Future<DataPdf> getPdfConvenios(
      {
        required String nameFile
       });


}
