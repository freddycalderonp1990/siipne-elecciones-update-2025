
import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:get/get.dart';

import '../app_censo/di.dart';
import '../app_elecciones/di.dart';
import '../feactures/di_feactures.dart';

class DependencyInjectionApp extends Bindings{

  static ini(){
    DependencyInjectionFeactures.init();
    DependencyInjectionMiUpc.ini();
    DependencyInjectionSiipneElecciones.ini();
    DependencyInjectionCenso.ini();
  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();


  }


}