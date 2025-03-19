part of '../../bindings.dart';

class CrearCodigoRecintosBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => CrearCodigoRecintosController(), fenix: true);


  }
}
