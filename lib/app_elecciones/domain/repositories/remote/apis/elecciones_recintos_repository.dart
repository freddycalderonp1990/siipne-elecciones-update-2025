part of '../../domain_repositories.dart';

abstract class EleccionesRecintosRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<RecintosElectoralesAbiertos> verificarperAsignadoRecElectoral(
      {required int idGenPersona});

  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos(
      {required double latitud,
      required double longitud,
      required int idDgoProcElec,
      required int idDgoTipoEje,

      });
}
