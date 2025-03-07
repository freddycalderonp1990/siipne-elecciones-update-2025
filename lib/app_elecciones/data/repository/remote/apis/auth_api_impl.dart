part of '../../data_repositories.dart';

class AuthApiImpl extends AuthRepository {
  final AuthApiProviderImpl _authApiProviderImpl;
  AuthApiImpl(this._authApiProviderImpl);

  @override
  Future<DataUser> auth(AuthRequest authRequest) async {

      return await _authApiProviderImpl.auth(authRequest);

  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
