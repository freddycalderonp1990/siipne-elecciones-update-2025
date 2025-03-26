part of '../../../providers_impl.dart';

class UrlApiProviderSiipneMovil {
  static Future<String> getToken() async {
    String token = await UrlApiProviderApp.getToken();
    return token;
  }

  static Future<String> post(
      {String segmento = '',
        Object? body,
        bool isLogin = false,
        bool onlyUrl = false}) async {
    String token = await getToken();

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();

    if (isLogin) {
      onlyUrl = true;
    }

    final String url = HostSiipneElecciones.gethost();

    return _urlApiProviderApp.post(
        url: url, segmento: segmento, body: body, isLogin: isLogin);
  }

  static Future<String> get(
      {required String segmento, bool onlyUrl = false}) async {
    String token = await getToken();

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    String url = HostSiipneElecciones.gethost();
    return _urlApiProviderApp.get(
      url: url,
      segmento: segmento,
    );
  }

  static Future<String> patch({String segmento = '', Object? body}) async {
    String token = await getToken();

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    final String url = HostSiipneElecciones.gethost();
    return _urlApiProviderApp.patch(url: url, segmento: segmento, body: body);
  }


  static Future<String> put({String segmento = '', Object? body}) async {
    String token = await getToken();
    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    final String url = HostSiipneElecciones.gethost();
    return _urlApiProviderApp.put(url: url, segmento: segmento, body: body);
  }

  static Future<String> delete({String segmento = '', Object? body}) async {
    String token = await getToken();
    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    final String url = HostSiipneElecciones.gethost();
    return _urlApiProviderApp.delete(url: url, segmento: segmento, body: body);
  }
}
