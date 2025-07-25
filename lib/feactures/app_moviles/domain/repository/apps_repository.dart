


import '../../data/models/apps_model.dart';
import '../request/verificar_update_request.dart';

abstract class AppsRepository {
  Future<DataApp> verificarUpdateApp({required VerificarUpdateRequest request});

}
