
import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../../domain/request/file_request.dart';
import '../models/file_model.dart';

abstract class FileRemoteDataSource {
  Future<DataFile> saveFile({required FileRequest request});

}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {


  @override
  Future<DataFile> saveFile({required FileRequest request}) async {
    Map<String, String>? body = {
      "path":request.path,
      "nameFile":request.nameFile
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();

    String segmento = dotenv.env['API_SAVE_FILE'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.postUploadFile(
      body: body, url: url, file: request.file, segmento: segmento,
    );

    return await ExceptionHelper.manejarErroresParseJsonException(() async {
      return fileModelFromJson(json).dataFile;
    });
  }
}


