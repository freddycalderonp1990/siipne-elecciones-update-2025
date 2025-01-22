part of '../../domain_repositories.dart';

abstract class EleccionesTipoEjesRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<TipoEjesActivos> getTipoEjesActivosEnProcesoOperativos(
      {required int usuario, required int idDgoProcElec});
}
