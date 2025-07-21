part of '../bindings.dart';

class CensistaBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => CensistaController(), fenix: true);


  }
}
