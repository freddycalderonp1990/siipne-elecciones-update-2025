
import '../../data/models/models_user.dart';
import '../entities/user.dart';
import '../request/request_user.dart';

abstract class UserRepository {
  Future<UserEntities> getDataUser({required int idGenUsuario,required String token});
  Future<DataAuth> auth({required AuthRequest request});


}
