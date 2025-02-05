part of '../../domain_repositories.dart';

abstract class PersonaRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DatosPer> getDatosPersona(
      {
        required String cedula,
        required int usuario});

  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral(
      {
        required int idDgoCreaOpReci,
        required int idGenPersona,
        required int usuario,
        required double latitud,
        required double longitud,
        required int idDgoReciElect,
        required int idDgoTipoEje,
        required String ip
      }) ;

}
