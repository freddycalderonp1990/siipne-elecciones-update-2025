part of '../../../providers_impl.dart';

class UrlApiProviderSiipneMovil {
  static int _secondsTimeout = AppConfig.secondsTimeout;

  static Future<String> getToken() async {
   String token=  await UrlApiProviderApp.getToken();
    return token;
  }

  static Future<String> post(
      {String segmento = '',
      Object? body,
      bool isLogin = false,
      bool onlyUrl = false}) async {

      String token = await getToken();

      UrlApiProviderApp _urlApiProviderApp =
          UrlApiProviderApp(secondsTimeout: _secondsTimeout, token: token);

      if (isLogin) {
        onlyUrl = true;
      }

      final String url = HostSiipneMovil.gethost(onlyUrl: onlyUrl);


      return _urlApiProviderApp.post(
          url: url, segmento: segmento, body: body, isLogin: isLogin);


  }

  static Future<String> get(
      {required String segmento, bool onlyUrl = false}) async {

      String token = await getToken();
      UrlApiProviderApp _urlApiProviderApp =
      UrlApiProviderApp(secondsTimeout: _secondsTimeout, token: token);

      String url = HostSiipneMovil.gethost(onlyUrl: onlyUrl);

      return _urlApiProviderApp.get(
          url: url, segmento: segmento,);

  }


  static Future<String> patch(
      {String segmento = '',
        Object? body

      }) async {

      String token = await getToken();

      UrlApiProviderApp _urlApiProviderApp =
      UrlApiProviderApp(secondsTimeout: _secondsTimeout, token: token);
      final String url = HostSiipneMovil.gethost();

      return _urlApiProviderApp.patch(
          url: url, segmento: segmento, body: body);


  }
}
