part of '../bindings.dart';


class PdfViewBinding extends Bindings{
  @override
  void dependencies() {

    print("HomeBinding-ok");
    //Inyeccion de dependencias
    Get.lazyPut(() => PdfViewController());




  }

}