part of '../bindings.dart';

class MenuAppEleccionesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuAppEleccionesController(), fenix: true);


  }
}
