part of '../bindings.dart';

class AnexarseBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => AnexarseController(), fenix: true);


  }
}
