

import '../../data/models/file_model.dart';
import '../repository/file_repository.dart';
import '../request/file_request.dart';

class SaveFileImgUseCase {
  final FileRepository repository;

  SaveFileImgUseCase({required this.repository});

  Future<DataFile> call({required FileRequest request}) {
    return repository.saveFile(request: request);
  }
}
