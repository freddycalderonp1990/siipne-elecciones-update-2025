part of '../../bindings.dart';

class MenuRecElecIntegranteBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuRecElecIntegranteController(), fenix: true);


  }
}
