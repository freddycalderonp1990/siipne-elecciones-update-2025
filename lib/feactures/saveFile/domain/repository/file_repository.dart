


import '../../data/models/file_model.dart';
import '../request/file_request.dart';

abstract class FileRepository {
  Future<DataFile> saveFile({required FileRequest request});

}
