import 'package:siipnemovil2/feactures/user/data/datasources/user_remote_data_source.dart';

import 'package:siipnemovil2/feactures/user/domain/entities/user.dart';
import 'package:siipnemovil2/feactures/user/domain/repository/user_repository.dart';
import 'package:siipnemovil2/feactures/user/domain/request/request_user.dart';

import '../../domain/mappers/mappers.dart';
import '../models/models_user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});


  @override
  Future<UserEntities> getDataUser({required int idGenUsuario}) async {
    UserModel dataUser = await userRemoteDataSource.getDataUser(idGenUsuario: idGenUsuario);
    return Mappers.fromDataUserToUserEntities(dataUser);
  }

  @override
  Future<String> auth({required AuthRequest request}) async {
   return userRemoteDataSource.auth(request: request);
  }
}
