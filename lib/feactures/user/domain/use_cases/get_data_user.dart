




import '../entities/user.dart';
import '../repository/user_repository.dart';

class GetDataUserUseCase {
  final UserRepository repository;

  GetDataUserUseCase({required this.repository});

  Future<UserEntities> call({required String token, required int  idGenUsuario }) {
    //no es necesario el idGenUsuario
    return repository.getDataUser(idGenUsuario: idGenUsuario,token: token);
  }
}
