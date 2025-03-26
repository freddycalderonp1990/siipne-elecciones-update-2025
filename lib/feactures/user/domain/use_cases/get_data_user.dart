


import 'package:siipnemovil2/feactures/user/domain/entities/user.dart';

import '../repository/user_repository.dart';

class GetDataUserUseCase {
  final UserRepository repository;

  GetDataUserUseCase({required this.repository});

  Future<UserEntities> call() {
    //no es necesario el idGenUsuario
    return repository.getDataUser(idGenUsuario: 0);
  }
}
