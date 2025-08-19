

import 'package:get/get.dart';
import 'package:siipnemovil2/app_censo/presentation/modules/totpCenso/totp_censo_controller.dart';

import 'data/datasources/censo_datasource_impl.dart';
import 'data/datasources/local/local_storage_censo_data_source.dart';
import 'data/repositories/censo_data_repositories.dart';
import 'data/repositories/local/local_storage_censo_repository_impl.dart';
import 'domain/repositories/domain_repositories.dart';
import 'domain/repositories/local/local_storage_censo_repository.dart';

import 'domain/usecases/censo_use_cases.dart';
import 'domain/usecases/local_store_censo.dart';




class DependencyInjectionCenso extends Bindings{

  static ini(){

    // Use cases
    Get.lazyPut<LocalStoreCensoUseCase>(()=>LocalStoreCensoUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<FetchCensusPersonDataUseCase>(()=>FetchCensusPersonDataUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<FetchActiveProcessesByCensusPersonUseCase>(()=>FetchActiveProcessesByCensusPersonUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<SaveCensusPersonPhotoUseCase>(()=>SaveCensusPersonPhotoUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<GetMesasByIdusuarioUseCase>(()=>GetMesasByIdusuarioUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<UpdateMesaCoordinatesUseCase>(()=>UpdateMesaCoordinatesUseCase(repository: Get.find()),fenix: true);
    Get.lazyPut<FetchDataHistoryCensusUseCase>(()=>FetchDataHistoryCensusUseCase(repository: Get.find()),fenix: true);



    // Repository
    Get.lazyPut<LocalStorageCensoRepository>(() =>
        LocalStorageCensoRepositoryImpl(localStorageCensoDataSource: Get.find()), fenix: true);
    Get.lazyPut<CensoRepository>(() =>
        CensoRepositoryImpl(censoRemoteDataSource: Get.find()), fenix: true);


    // Data sources
    Get.lazyPut<LocalStorageCensoDataSource>(() => LocalStorageCensoDataSourceImpl(),
        fenix: true);
    Get.lazyPut<CensoRemoteDataSource>(() => CensoRemoteDataSourceImpl(),
        fenix: true);


    Get.put(TotpCensoController());
  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();

  }


}