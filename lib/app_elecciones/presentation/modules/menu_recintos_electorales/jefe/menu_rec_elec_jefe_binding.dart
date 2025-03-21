part of '../../bindings.dart';

class MenuRecElecJefeBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MenuRecElecJefeController(), fenix: true);


  }
}
