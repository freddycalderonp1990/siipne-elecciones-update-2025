

import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';



import '../../domain/request/request_user.dart';
import '../models/models_user.dart';



abstract class UserRemoteDataSource {
  Future<UserModel> getDataUser({required int idGenUsuario, required String token});
  Future<DataAuth> auth({required AuthRequest request});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  @override
  Future<UserModel> getDataUser({required int idGenUsuario,required String token}) async {
    Object? body = {
      "idGenUsuario":idGenUsuario
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp(token: token);
    String segmento = dotenv.env['API_GET_DATA_USUARIO'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.post(
      body: body, url: url,

    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return dataUserFromJson(json).user;
    });
  }

  @override
  Future<DataAuth> auth({required AuthRequest request}) async  {

    Map<String, dynamic> body = {
      ...request.toJson(), // Agrega los valores del bodyRequest al mapa usando spread operator
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();


    String segmento = dotenv.env['API_AUTH'] ?? '';

    String url = HostApp.gethost( segmento: segmento);
    print("la url es ${url}");

    String json = await _urlApiProviderApp.post(
      isLogin: true,
      body: body, url: url,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return authModelFromJson(json).dataAuth;
    });
  }
}


