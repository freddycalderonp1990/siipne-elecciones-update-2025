part of '../../domain_repositories.dart';

abstract class PersonaRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DatosPer> getDatosPersona(
      {
        required String cedula,
        required int usuario,
        int? idDgoProcElec,

      });

  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral(
      {
        required AddPersonalRequest request,
      }) ;


  Future<List<PersonalRecintoElectoral>> consultarDatosPersonalAsignadoRecintoElectoral({
    required int idDgoCreaOpReci,
    required int idDgoProcElec,
    required int idDgoReciElect,
  });


  Future<PerSituacion> verificarSiPersonaEstaBloqueado({
    required int idDgoProcElec,
    required int idGenPersona,
  });
}
