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
      {  required AddPersonalRequest request}) async {
    return await _personaApiProviderImpl.asignarPersonalEnRecintoElectoral(
       request: request);
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
