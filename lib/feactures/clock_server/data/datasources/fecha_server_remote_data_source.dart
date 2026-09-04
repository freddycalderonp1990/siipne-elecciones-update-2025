
import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';

import '../models/time_server_model.dart';

abstract class FechaServerDataSource {
  Future<DateTime> getTimeServer();

}

class FechaServerDataSourceImpl implements FechaServerDataSource {
  @override
  Future<DateTime> getTimeServer() async {
    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    String segmento = 'appmovil/appSiipneApi/index.php';
    String url = HostApp.gethost( segmento: segmento);

    Object? body = {
      "opc": "e88822bacb3ac89fd006b85865119911",
      "modulo": "6f9c4e8a50188ea0301c49853cf3f264",

    };

    String json = await _urlApiProviderApp.post(
      body: body, url: url,

    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return timeServerModelFromJson(json).time;
    });
  }








}


