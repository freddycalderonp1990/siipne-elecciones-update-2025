part of '../../bindings.dart';

class RecintosCrearCodigoBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => RecintosCrearCodigoController(), fenix: true);


  }
}
