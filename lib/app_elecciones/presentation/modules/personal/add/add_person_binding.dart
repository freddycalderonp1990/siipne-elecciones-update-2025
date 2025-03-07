part of '../../bindings.dart';

class AddPersonBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => AddPersonController(), fenix: true);


  }
}
