part of '../../data_repositories.dart';

class AuthApiImpl extends AuthRepository {
  final AuthApiProviderImpl _authApiProviderImpl;
  AuthApiImpl(this._authApiProviderImpl);

  @override
  Future<DataUser> auth(AuthRequest authRequest) async {
    try {
      return await _authApiProviderImpl.auth(authRequest);
    } on ParseJsonException catch (e) {
      throw ParseJsonException(message: e.message);
    } on UpdateAppException catch (e) {
      throw UpdateAppException(message: e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e,t) {
      if (AppConfig.activarMocks) {
        try {
          final json = await rootBundle.rootBundle.loadString(AppMocks.auth);
          DataAuth authModel = authModelFromJson(json).dataAuth;

          DataUser dataUser = obtenerDataUserDesdeToken(authModel.token);
          dataUser =
              dataUser.copyWith(token: authModel.token, foto: authModel.foto);

          return dataUser;
        } catch (e,t) {
          throw ExceptionHelper.captureError(e,t);
        }
      }

      throw ExceptionHelper.captureError(e,t);
    }
  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
