
import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:get/get.dart';


import '../app_elecciones/dependency_injection_siipne.dart';
import '../feactures/di.dart';
import 'data/provider/providers_impl_app.dart';
import 'data/repository/data_repositories.dart';
import 'domain/repositories/domain_repositories.dart';


class DependencyInjectionApp extends Bindings{

  static ini(){


    DependencyInjectionUser.init();
    DependencyInjectionSiipne.ini();
    DependencyInjectionMiUpc.ini();


  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();




  }


}