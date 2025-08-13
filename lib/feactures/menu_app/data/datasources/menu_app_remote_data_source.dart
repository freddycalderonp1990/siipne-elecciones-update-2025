
import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/menu_app_model.dart';



abstract class MenuAppRemoteDataSource {
  Future<DataMenu> getDataMenuApps();

}

class MenuAppRemoteDataSourceImpl implements MenuAppRemoteDataSource {


  @override
  Future<DataMenu> getDataMenuApps() async {

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    String segmento = dotenv.env['API_GET_MENU_APPS'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.post(
      body: null, url: url,

    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return menuAppModelFromJson(json).dataMenu;
    });
  }
}


