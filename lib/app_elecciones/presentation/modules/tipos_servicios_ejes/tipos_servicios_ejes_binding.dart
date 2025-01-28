part of '../bindings.dart';

class TiposServiciosEjesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => TiposServiciosEjesController(), fenix: true);


  }
}
