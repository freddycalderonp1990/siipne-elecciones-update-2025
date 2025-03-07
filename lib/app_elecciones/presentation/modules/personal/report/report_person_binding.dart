part of '../../bindings.dart';

class ReportPersonBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => ReportPersonController(), fenix: true);


  }
}
