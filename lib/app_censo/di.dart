

import 'package:get/get.dart';




class DependencyInjectionCenso extends Bindings{

  static ini(){


    //DATA

    //Domain

    //  Get.lazyPut<EleccionesProcesosApiImpl> (() => EleccionesProcesosApiImpl(EleccionesProcesosApiProviderImpl()), fenix: true);


  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();

    /* Get.lazyPut<Dio>(() => Dio(BaseOptions(baseUrl: 'http://192.168.80.90')));
    Get.lazyPut<LoginApi>(() => LoginApi());
    Get.lazyPut<LoginRepository>(() => LoginRepository());*/
  }


}