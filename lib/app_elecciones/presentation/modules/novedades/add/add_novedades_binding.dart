part of '../../bindings.dart';

class AddNovedadesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => AddNovedadesController(), fenix: true);


  }
}
