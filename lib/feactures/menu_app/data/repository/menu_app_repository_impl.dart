import '../../domain/repository/menu_app_repository.dart';
import '../datasources/menu_app_remote_data_source.dart';
import '../models/menu_app_model.dart';

class MenuAppRepositoryImpl implements MenuAppRepository {
  final MenuAppRemoteDataSource menuAppRemoteDataSource;

  MenuAppRepositoryImpl({required this.menuAppRemoteDataSource});


  @override
  Future<DataMenu> getDataMenuApps()  async {

   return menuAppRemoteDataSource.getDataMenuApps();
  }


}
