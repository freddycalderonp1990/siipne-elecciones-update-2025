

part of '../../domain_repositories.dart';

abstract class AuthRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DataUser> auth(AuthRequest authRequest) ;




  Future<void> logout (String token);



}