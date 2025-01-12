part of '../bindings.dart';

class MenuUnidadesPolicialesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuUnidadesPolicialesController(), fenix: true);


  }
}
