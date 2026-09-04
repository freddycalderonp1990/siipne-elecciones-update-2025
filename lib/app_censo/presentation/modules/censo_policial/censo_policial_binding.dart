part of '../bindings.dart';

class CensoPolicialBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => CensoPolicialController(), fenix: true);

  }
}
