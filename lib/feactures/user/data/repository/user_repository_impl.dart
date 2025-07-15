

import '../../domain/entities/user.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/repository/user_repository.dart';
import '../../domain/request/request_user.dart';
import '../data_sources/user_remote_data_source.dart';

import '../models/models_user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;


  UserRepositoryImpl({required this.userRemoteDataSource});


  @override
  Future<UserEntities> getDataUser({required int idGenUsuario,required String token}) async {
    UserModel dataUser = await userRemoteDataSource.getDataUser(idGenUsuario: idGenUsuario,token: token);
    return Mappers.fromDataUserToUserEntities(dataUser);
  }

  @override
  Future<DataAuth> auth({required AuthRequest request}) async {
   return userRemoteDataSource.auth(request: request);
  }

}
