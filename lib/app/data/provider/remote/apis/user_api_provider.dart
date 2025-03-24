
part of '../../providers_impl_app.dart';



class AuthApiProviderImpl extends UserRepository {

  @override
  Future<User> getDataUser() async {
    Object? body = {
    };

    String token = await UrlApiProviderApp.getToken();
    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp(token: token);

    String segmento = dotenv.env['API_GET_DATA_USUARIO'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.post(
      isLogin: true,
      body: body, url: url,

    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {

      return dataUserFromJson(json).user;
    });
  }
}
