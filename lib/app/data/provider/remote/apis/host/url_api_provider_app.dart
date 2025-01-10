

part of '../../../providers_impl_app.dart';


class UrlApiProviderApp {
  String tag="UrlProvider";
  final int secondsTimeout;
  final String? token;

  UrlApiProviderApp({this.secondsTimeout = 8, this.token});

  Map<String, String> getheaders({required String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }



  static Future<String> getToken() async {
    LocalStorageRepository _localStorageRepository =
    Get.find<LocalStorageRepository>();


    DataUser dataUser= await _localStorageRepository.getUserModel();

    String token = dataUser.token;

    return token;
  }


  Future<String> post(
      {String segmento = '',
      Object? body,
      required String url,
      bool isLogin = false}) async {
    try {
      http.Client client = http.Client();

      print("la url es ${url}");
      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }


      String _tag=tag+" POST ";
      PrintsMsj.myLog(tag:_tag , title: "uri:", detalle: uri.toString());
      final response = await client
          .post(uri,
              body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: this.secondsTimeout));

      PrintsMsj.myLog(tag:_tag ,title: "body-request:", detalle: body.toString());
      PrintsMsj.myLog(tag:_tag ,title: "statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag:_tag ,title: "body-response:", detalle: response.body.toString());

      if (response.statusCode == 200) {
        return response.body.toString();
      } else if (response.statusCode == 401 && isLogin) {
        throw ServerException(cause: "Usuario / Clave incorrecta");
      } else if (response.statusCode == 423 && isLogin) {
        String json = response.body.toString();
        CabeceraJsonModel data = CabeceraJsonModel.fromJson(json);
        throw ServerException(cause: data.message);

      } else {
        String json = response.body.toString();
        CabeceraJsonModel data = CabeceraJsonModel.fromJson(json);

        throw ServerException.StatusCode(statusCode: response.statusCode,msjException: data.message);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  Future<String> get({
    required String segmento,
    required String url,
  }) async {
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      final response =
          await client.get(uri, headers: getheaders(token: this.token)).timeout(
                Duration(seconds: this.secondsTimeout),
              );

      String _tag=tag+" GET ";

      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-request:", detalle: "NO BODY");
      PrintsMsj.myLog(tag: _tag,title: "-statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-response:", detalle: response.body.toString());

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  Future<String> delete(
      {required String segmento, Object? body, required String url}) async {
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }



      final response = await client
          .delete(uri,
              headers: getheaders(token: this.token), body: jsonEncode(body))
          .timeout(
            Duration(seconds: this.secondsTimeout),
          );
      String _tag=tag+" DELETE ";
      PrintsMsj.myLog(tag: _tag,title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(tag: _tag,title: "-statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-response:", detalle: response.body.toString());

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  //Modifica toda la data
  Future<String> put(
      {String segmento = '', Object? body, required String url}) async {
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      final response = await client
          .put(uri,
              body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: this.secondsTimeout));

      String _tag=tag+" PUT ";
      PrintsMsj.myLog(tag: _tag,title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(tag: _tag,title: "-statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-response:", detalle: response.body.toString());

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }


  //Modifica Parte de la data

  Future<String> patch(
      {String segmento = '', Object? body, required String url}) async {
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      final response = await client
          .patch(uri,
          body: jsonEncode(body), headers: getheaders(token: this.token))
          .timeout(Duration(seconds: this.secondsTimeout));
      String _tag=tag+" PATCH ";
      PrintsMsj.myLog(tag: _tag,title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(tag: _tag,title: "-statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag: _tag,title: "-body-response:", detalle: response.body.toString());

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  Future<String> postUploadFile(
      {required doc.File file,
      required String segmento,
      required String url, Map<String, String>? body}) async {
    try {
      String? parsed = null;

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }



      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();


      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path),
          contentType: MediaType("text", "plain"));

      request.files.add(multipartFile);

      request.headers.addAll(getheaders(token: this.token));



      if(body!=null) {
        request.fields.addAll(body);
      }


      http.StreamedResponse response = await request.send();

      parsed = await response.stream.transform(utf8.decoder).first;



      String _tag=tag+" POST-UPDATE-FILE ";

      PrintsMsj.myLog(tag: _tag,title: "postUploadFile-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag,title: "postUploadFile-body-request:", detalle: "IS FILE");
      PrintsMsj.myLog(tag: _tag,title: "postUploadFile-statusCode:", detalle: response.statusCode.toString());
      PrintsMsj.myLog(tag: _tag,title: "postUploadFile-body-response:", detalle: parsed.toString());




      if (response.statusCode == 200) {
        return parsed.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
