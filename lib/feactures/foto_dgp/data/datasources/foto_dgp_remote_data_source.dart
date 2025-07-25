import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siipnemovil2/feactures/foto_dgp/data/models/foto_model.dart';


abstract class FotoDgpRemoteDataSource {
  Future<DataFoto> getFotoByDocumento({required String documento});
}

class FotoDgpRemoteDataSourceImpl implements FotoDgpRemoteDataSource {
  @override
  Future<DataFoto> getFotoByDocumento({required String documento}) async {
    Map<String, dynamic> body = {"documento": documento};

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();
    String segmento = dotenv.env['API_GET_FOTO_BY_DOCUMENTO'] ?? '';
    String url = HostApp.gethost(segmento: segmento);

    String json = await _urlApiProviderApp.post(body: body, url: url);

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return fotoModelFromJson(json).dataFoto;
    });
  }
}
