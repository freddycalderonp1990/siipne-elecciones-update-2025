part of '../../data_repositories.dart';

class PersonaApiImpl extends PersonaRepository {
  final PersonaApiProviderImpl _personaApiProviderImpl;

  PersonaApiImpl(this._personaApiProviderImpl);

  @override
  Future<DatosPer> getDatosPersona(
      {required String cedula, required int usuario}) async {
    return await _personaApiProviderImpl.getDatosPersona(
        cedula: cedula, usuario: usuario);
  }

  @override
  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral(
      {required int idDgoCreaOpReci,
      required int idGenPersona,
      required int usuario,
      required double latitud,
      required double longitud,
      required int idDgoReciElect,
      required int idDgoTipoEje,
        required int idDgoProcElec,

      required String ip}) async {
    return await _personaApiProviderImpl.asignarPersonalEnRecintoElectoral(
        idDgoCreaOpReci: idDgoCreaOpReci,
        idGenPersona: idGenPersona,
        usuario: usuario,
        latitud: latitud,
        longitud: longitud,
        idDgoReciElect: idDgoReciElect,
        idDgoTipoEje: idDgoTipoEje,
        idDgoProcElec: idDgoProcElec,
        ip: ip);
  }

  @override
  Future<List<PersonalRecintoElectoral>>
      consultarDatosPersonalAsignadoRecintoElectoral(
          {required int idDgoCreaOpReci,    required int idDgoProcElec,
            required int idDgoReciElect,}) async {
    return _personaApiProviderImpl
        .consultarDatosPersonalAsignadoRecintoElectoral(
        idDgoProcElec: idDgoProcElec,
            idDgoReciElect: idDgoReciElect,
            idDgoCreaOpReci: idDgoCreaOpReci);
  }
}
