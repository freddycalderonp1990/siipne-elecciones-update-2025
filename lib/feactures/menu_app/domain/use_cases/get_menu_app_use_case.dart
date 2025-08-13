import '../../data/models/menu_app_model.dart';
import '../repository/menu_app_repository.dart';

class GetMenuAppUseCase {
  final MenuAppRepository repository;

  GetMenuAppUseCase({required this.repository});

  Future<DataMenu> call() {
    return repository.getDataMenuApps();
  }
}
