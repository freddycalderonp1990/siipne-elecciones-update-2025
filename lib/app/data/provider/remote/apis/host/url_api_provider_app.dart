

part of '../../../providers_impl_app.dart';
//se elimina la variable secondsTimeout, XQ NO SE ESTABA ASIGANDO EL TIEMPO

class UrlApiProviderApp {
  String tag = "UrlProvider";

  final String? token;

  UrlApiProviderApp({this.token});

  Map<String, String> getheaders({required String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<String> getToken() async {
    LocalStoreUseCase localStoreUseCase =
    Get.find();
    final UserEntities user=await localStoreUseCase.getUserModel();
    final token =  user.token;
    return token;
  }
  Future<String> post(
      {String segmento = '',
        Object? body,
        required String url,
        bool isLogin = false}) async {
    late final response;
    try {
      http.Client client = http.Client();

      print("la url es ${url}");
      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      String _tag = tag + " POST ";
      PrintsMsj.myLog(tag: _tag, title: "uri:", detalle: uri.toString());
      response = await client
          .post(uri,
          body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: AppConfig.secondsTimeout));

      PrintsMsj.myLog(
          tag: _tag, title: "body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else if (response.statusCode == 401 && isLogin) {
      throw ServerException(message: "Usuario / Clave incorrecta");
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }

  Future<String> get({
    required String segmento,
    required String url,

  }) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      print("timeOut ${AppConfig.secondsTimeout}");
      response =
      await client.get(uri, headers: getheaders(token: this.token)).timeout(
        Duration(seconds: AppConfig.secondsTimeout),
      );

      String _tag = tag + " GET ";

      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag, title: "-body-request:", detalle: "NO BODY");
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }

  Future<String> delete(
      {required String segmento, Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      response = await client
          .delete(uri,
          headers: getheaders(token: this.token), body: jsonEncode(body))
          .timeout(
        Duration(seconds: AppConfig.secondsTimeout),
      );
      String _tag = tag + " DELETE ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }

  //Modifica toda la data
  Future<String> put(
      {String segmento = '', Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      response = await client
          .put(uri,
          body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: AppConfig.secondsTimeout));

      String _tag = tag + " PUT ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }

  //Modifica Parte de la data

  Future<String> patch(
      {String segmento = '', Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      response = await client
          .patch(uri,
          body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: AppConfig.secondsTimeout));
      String _tag = tag + " PATCH ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }

  Future<String> postUploadFile(
      {required doc.File file,
        required String segmento,
        required String url,
        Map<String, String>? body}) async {
    http.StreamedResponse response;
    String? parsed = null;
    try {
      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      //old -> var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var stream = http.ByteStream(file.openRead().cast());
      var length = await file.length();
      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path),
          contentType: MediaType("text", "plain"));

      request.files.add(multipartFile);
      request.headers.addAll(getheaders(token: this.token));
      if (body != null) {
        request.fields.addAll(body);
      }

      response = await request.send();
      parsed = await response.stream.transform(utf8.decoder).first;
      String _tag = tag + " POST-UPDATE-FILE ";
      PrintsMsj.myLog(
          tag: _tag, title: "postUploadFile-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "postUploadFile-body-request:", detalle: "IS FILE");
      PrintsMsj.myLog(
          tag: _tag,
          title: "postUploadFile-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "postUploadFile-body-response:",
          detalle: parsed.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, stackTrace);
    }
    if (response.statusCode == 200) {
      return parsed.toString();
    } else {
      throw ServerException.StatusCode(response: response);
    }
  }
}
