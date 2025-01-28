
import '../app_elecciones/presentation/modules/controllers.dart';

import 'data/repository/data_repositories.dart';


import 'data/providers/providers_impl.dart';
import 'domain/repositories/domain_repositories.dart';

import 'package:get/get.dart';


class DependencyInjectionSiipne extends Bindings{

  static ini(){


    //DATA


    Get.lazyPut<LocalStoreImpl> (() => LocalStoreImpl(LocalStoreProviderImpl()), fenix: true);

    //Domain
    Get.lazyPut<AuthApiImpl> (() => AuthApiImpl(AuthApiProviderImpl()), fenix: true);
    Get.lazyPut<EleccionesProcesosApiImpl> (() => EleccionesProcesosApiImpl(EleccionesProcesosApiProviderImpl()), fenix: true);
    Get.lazyPut<EleccionesRecintosApiImpl> (() => EleccionesRecintosApiImpl(EleccionesRecintosApiProviderImpl()), fenix: true);
    Get.lazyPut<EleccionesTipoEjesApiImpl> (() => EleccionesTipoEjesApiImpl(EleccionesTipoEjesApiProviderImpl()), fenix: true);

    //Providers
    Get.lazyPut<LocalStorageRepository> (() => LocalStoreImpl(LocalStoreProviderImpl()), fenix: true);


    //realizo la inyecto para utilizarla enm toda la aplicacion
    Get.put(LoginController());
    Get.put(MyGpsController());



    //Get.create<GpsController> (() => GpsController());

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