part of '../bindings.dart';

class MenuAppCensoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuAppCensoController(), fenix: true);

  }
}
