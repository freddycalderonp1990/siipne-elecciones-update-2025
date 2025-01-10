
import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:get/get.dart';


import '../app_elecciones/dependency_injection_siipne.dart';


class DependencyInjectionApp extends Bindings{

  static ini(){
    DependencyInjectionSiipne.ini();
    DependencyInjectionMiUpc.ini();


  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();




  }


}