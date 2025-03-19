part of '../../domain_repositories.dart';

abstract class EleccionesRecintosRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<RecintosElectoralesAbiertos> verificarperAsignadoRecElectoral(
      {required int idGenPersona});

  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos({
    required RecintoCercanosRequest request,
  });

  Future<AbrirRecintoElectoral> crearCodigo({
    required CreateCodeRecintoRequest request,
  });

  Future<bool> abandonarRecintoElectoral({
    required AbandonarRecintoRequest request,
  });

  Future<datosFinalizarProceso> finalizarRecintoElectoral(
      {required FinalizarRecintoRequest request});

//se retorna como estring xq vienen los mensajes desde el server
  Future<String> eliminarRecintoElectoralAbierto({
    required EliminarRecintoRequest request,
  });
}
