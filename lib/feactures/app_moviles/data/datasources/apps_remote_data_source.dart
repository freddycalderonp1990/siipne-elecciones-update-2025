
import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/request/verificar_update_request.dart';
import '../models/apps_model.dart';



abstract class AppsRemoteDataSource {
  Future<DataApp> verificarUpdateApp({required VerificarUpdateRequest request});

}

class AppsRemoteDataSourceImpl implements AppsRemoteDataSource {


  @override
  Future<DataApp> verificarUpdateApp({required VerificarUpdateRequest request}) async {
    Map<String, dynamic> body = request.toJson();


    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    String segmento = dotenv.env['API_VERIFICAR_UPDATE_APP'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.post(
      body: body, url: url,

    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      List<DataApp> dataApps=appsModelFromJson(json).dataApps;
      if(dataApps.length==0){
        return DataApp.empty();
      }

      return dataApps[0];
    });
  }
}


