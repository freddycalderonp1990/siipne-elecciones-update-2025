part of '../../data_repositories.dart';

class AuthApiImpl extends AuthRepository {
  final AuthApiProviderImpl _authApiProviderImpl;
  AuthApiImpl(this._authApiProviderImpl);

  @override
  Future<DataUser> auth(AuthRequest authRequest) async {
    try {
      return await _authApiProviderImpl.auth(authRequest);
    }catch (e) {

      if(AppConfig.activarMocks){
        try {
          final json = await rootBundle.rootBundle.loadString(AppMocks.auth);
          DataAuth authModel = authModelFromJson(json).dataAuth;

          DataUser dataUser = obtenerDataUserDesdeToken(authModel.token);
          dataUser =
              dataUser.copyWith(token: authModel.token, foto: authModel.foto);

          return dataUser;
        }
        catch(e){
          throw ExceptionHelper.captureError(e);
        }
      }

      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }



}
