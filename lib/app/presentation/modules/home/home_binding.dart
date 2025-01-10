part of '../bindings.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => HomeController(), fenix: true);


  }
}
