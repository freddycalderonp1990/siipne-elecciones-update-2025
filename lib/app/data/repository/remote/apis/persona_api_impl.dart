part of '../../data_repositories.dart';

class PersonaApiImpl extends PersonaRepository {
  final PersonaApiProviderImpl _personaApiProviderImpl;

  PersonaApiImpl(this._personaApiProviderImpl);

  @override
  Future<DatosPer> getDatosPersona(
      {required String cedula, required int usuario,  int? idDgoProcElec}) async {
    return await _personaApiProviderImpl.getDatosPersona(
        cedula: cedula, usuario: usuario,idDgoProcElec: idDgoProcElec);
  }

  @override
  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral(
      {required AddPersonalRequest request}) async {
    return await _personaApiProviderImpl.asignarPersonalEnRecintoElectoral(
        request: request);
  }

  @override
  Future<List<PersonalRecintoElectoral>>
      consultarDatosPersonalAsignadoRecintoElectoral({
    required int idDgoCreaOpReci,
    required int idDgoProcElec,
    required int idDgoReciElect,
  }) async {
    return _personaApiProviderImpl
        .consultarDatosPersonalAsignadoRecintoElectoral(
            idDgoProcElec: idDgoProcElec,
            idDgoReciElect: idDgoReciElect,
            idDgoCreaOpReci: idDgoCreaOpReci);
  }

  @override
  Future<PerSituacion> verificarSiPersonaEstaBloqueado(
      {required int idDgoProcElec, required int idGenPersona}) async {
    return _personaApiProviderImpl.verificarSiPersonaEstaBloqueado(
        idDgoProcElec: idDgoProcElec, idGenPersona: idGenPersona);
  }
}
