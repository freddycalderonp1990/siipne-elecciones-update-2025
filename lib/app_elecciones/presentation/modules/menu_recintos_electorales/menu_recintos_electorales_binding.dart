part of '../bindings.dart';

class MenuRecintosElectoralesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuRecintosElectoralesController(), fenix: true);


  }
}
