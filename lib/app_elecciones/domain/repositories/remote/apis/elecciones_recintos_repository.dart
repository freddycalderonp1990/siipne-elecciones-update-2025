

part of '../../domain_repositories.dart';



abstract class EleccionesRecintosRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<RecintosElectoralesAbiertos> verificarperAsignadoRecElectoral({required int idGenPersona}) ;


}