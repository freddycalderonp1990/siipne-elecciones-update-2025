

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siipnemovil2/app/core/exceptions/exception_helper.dart';
import 'package:siipnemovil2/app/data/provider/providers_impl_app.dart';

import '../../../../app_elecciones/data/providers/providers_impl.dart';
import '../../../../app_elecciones/data/providers/remote/apis/api_constantes.dart';
import '../../../../app_elecciones/domain/request/request.dart';
import '../../domain/request/request_user.dart';
import '../models/models_user.dart';



abstract class UserRemoteDataSource {
  Future<UserModel> getDataUser({required int idGenUsuario});
  Future<DataAuth> auth({required AuthRequest request});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  @override
  Future<UserModel> getDataUser({required int idGenUsuario}) async {
    Object? body = {
      "idGenUsuario":idGenUsuario
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
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

  @override
  Future<DataAuth> auth({required AuthRequest request}) async  {

    Map<String, dynamic> body =
    HeadEleccionesRequest(
      uri: ApiConstantes.AUTH,
      bodyRequest: request.toJson(),
    ).toJson();

    String json = await UrlApiProviderSiipneMovil.post(
      isLogin: true,
      body: body,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return authModelFromJson(json).dataAuth;
    });
  }
}


