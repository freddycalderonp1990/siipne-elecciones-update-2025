

import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';



import '../../domain/request/request_push_notification.dart';
import '../models/models_user.dart';



abstract class PushNotificationRemoteDataSource {
  Future<bool> insertarToken({required PushTokenRequest request});
}

class PusNotificationFirebaseRemoteDataSourceImpl implements PushNotificationRemoteDataSource {


  @override
  Future<bool> insertarToken({required PushTokenRequest request}) async {

    Map<String, dynamic> body = {
      ...request.toJson(), // Agrega los valores del bodyRequest al mapa usando spread operator
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();


    String segmento = dotenv.env['INSERT_PUSH_TOKEN'] ?? '';

    String url = HostApp.gethost( segmento: segmento);
    print("la url es ${url}");

    String json = await _urlApiProviderApp.post(
      isLogin: true,
      body: body, url: url,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return true;
    });
  }
}


