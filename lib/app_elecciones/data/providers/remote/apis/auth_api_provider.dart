part of '../../providers_impl.dart';

class AuthApiProviderImpl extends AuthRepository {
  @override
  Future<DataUser> auth(AuthRequest authRequest) async {
    Object? body = {
      "modulo": ApiConstantes.MODULO,
      "uri": ApiConstantes.AUTH,
      "user": authRequest.user,
      "pass": authRequest.pass,
      "isAndroid": authRequest.isAndroid,
      "versionCodeApp": authRequest.versionCodeApp,
      "ip": authRequest.ip
    };

    String json = await UrlApiProviderSiipneMovil.post(
      isLogin: true,
      body: body,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {

      DataAuth authModel = authModelFromJson(json).dataAuth;
      DataUser dataUser = obtenerDataUserDesdeToken(authModel.token);
      dataUser =
          dataUser.copyWith(token: authModel.token, foto: authModel.foto);
      return dataUser;
    });
  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
