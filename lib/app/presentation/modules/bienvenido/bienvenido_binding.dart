part of '../bindings.dart';

class BienvenidoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => BienvenidoController(), fenix: true);


  }
}
