part of '../bindings.dart';

class SelectProcesoOperativoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => SelectProcesoOperativoController(), fenix: true);


  }
}
