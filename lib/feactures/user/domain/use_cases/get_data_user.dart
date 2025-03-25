


import 'package:siipnemovil2/feactures/user/domain/entities/user.dart';

import '../repository/user_repository.dart';

class GetDataUserUseCase {
  final UserRepository repository;

  GetDataUserUseCase({required this.repository});

  Future<UserEntities> call({required String token,required int idGenUsuario}) {
    return repository.getDataUser(token: token,idGenUsuario: idGenUsuario);
  }
}
