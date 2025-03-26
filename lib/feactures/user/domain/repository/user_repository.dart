
import '../entities/user.dart';
import '../request/request_user.dart';

abstract class UserRepository {
  Future<UserEntities> getDataUser({required int idGenUsuario});
  Future<String> auth({required AuthRequest request});

}
