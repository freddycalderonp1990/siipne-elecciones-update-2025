part of '../../bindings.dart';

class InicioRapidoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InicioRapidoController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);

  }

}