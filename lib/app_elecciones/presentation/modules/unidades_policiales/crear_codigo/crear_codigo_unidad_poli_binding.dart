part of '../../bindings.dart';

class CrearCodigoUnidadPoliBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => CrearCodigoUnidadPoliController(), fenix: true);


  }
}
