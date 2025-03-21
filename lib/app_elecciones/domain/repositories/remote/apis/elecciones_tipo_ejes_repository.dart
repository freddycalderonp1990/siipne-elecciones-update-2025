part of '../../domain_repositories.dart';

abstract class EleccionesTipoEjesRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<TipoEjesActivos> getTipoEjesActivosEnProcesoOperativos(
      {required int usuario, required int idDgoProcElec});

  Future<List<UnidadesPoliciale>> getUnidadesPoliciales({required int usuario});

  Future<List<DatosUnidadesId>> getUnidadesPolicialesById(
      {required int idDgoTipoEje});

  Future<List<UnidadesPoliciale>> getTipoEjePorIdPadre(
      {required int usuario, required int idDgoTipoEje});
}
