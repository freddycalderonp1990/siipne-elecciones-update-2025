import 'package:get/get.dart';
import 'package:siipnemovil2/feactures/clock_server/domain/use_cases/local_store_clock_server.dart';

import 'data/datasources/fecha_server_remote_data_source.dart';
import 'data/datasources/local_storage_data_source.dart';
import 'data/repository/fecha_server_repository_impl.dart';
import 'data/repository/local_storage_repository_impl.dart';
import 'date_time_controller.dart';
import 'domain/repository/fecha_server_repository.dart';
import 'domain/repository/local_storage_repository.dart';
import 'domain/use_cases/get_fecha_server_use_case.dart';

class DependencyInjectionClockServer {
  static init() async {
    // Use cases
    Get.lazyPut<LocalStoreClockServerUseCase>(
      () => LocalStoreClockServerUseCase(repository: Get.find()),
      fenix: true,
    );

    Get.lazyPut<GetFechaServerUseCase>(
      () => GetFechaServerUseCase(repository: Get.find()),
      fenix: true,
    );

    // Repository
    Get.lazyPut<FechaServerRepository>(
      () => FechaServerRepositoryImpl(fechaServerDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LocalStorageClockServerRepository>(
      () => LocalStorageClockServerRepositoryImpl(
        localStorageDataSource: Get.find(),
      ),
      fenix: true,
    );

    // Data sources
    Get.lazyPut<FechaServerDataSource>(
      () => FechaServerDataSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<LocalStorageClockServerDataSource>(
      () => LocalStorageClockServerDataSourceImpl(),
      fenix: true,
    );

    Get.put(DateTimeController());
  }
}
