

part of '../../domain_repositories.dart';

abstract class BeneficiosRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<List<DataCatBeneficio> > getCategoriaBeneficios() ;

  Future<List<DataCatBeneficio> > getCatalogoBeneficios({required int idDbsCatBeneficios}) ;

  Future<List<DataConvenio> > getConveniosByIdEmpresa({required int idDbsEmpresa}) ;


}