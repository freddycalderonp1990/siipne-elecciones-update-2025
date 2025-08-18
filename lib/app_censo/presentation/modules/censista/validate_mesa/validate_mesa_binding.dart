part of '../../bindings.dart';

class ValidateMesaBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => ValidateMesaController(), fenix: true);


  }
}
