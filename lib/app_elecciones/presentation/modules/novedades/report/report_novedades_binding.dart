part of '../../bindings.dart';

class ReportNovedadesBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => ReportNovedadesController(), fenix: true);


  }
}
