part of '../bindings.dart';

class HistorialCensoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => HistorialCensoController(), fenix: true);

  }
}
