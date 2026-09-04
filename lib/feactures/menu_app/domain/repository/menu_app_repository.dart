import '../../data/models/menu_app_model.dart';

abstract class MenuAppRepository {
  Future<DataMenu> getDataMenuApps();

}
