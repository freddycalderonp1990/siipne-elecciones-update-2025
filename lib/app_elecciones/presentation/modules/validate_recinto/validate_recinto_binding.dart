part of '../bindings.dart';



class ValidateRecintoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => ValidateRecintoController(), fenix: true);


  }
}
