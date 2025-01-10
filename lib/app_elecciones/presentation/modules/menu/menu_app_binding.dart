part of '../bindings.dart';

class MenuAppBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuAppController(), fenix: true);


  }
}
