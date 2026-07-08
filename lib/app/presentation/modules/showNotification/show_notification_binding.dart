part of '../bindings.dart';

class ShowNotificationBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => ShowNotificationController(), fenix: true);


  }
}
