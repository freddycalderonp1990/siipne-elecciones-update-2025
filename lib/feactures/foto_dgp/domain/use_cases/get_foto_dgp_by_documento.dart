

import '../../data/models/foto_model.dart';
import '../repository/foto_dgp_repository.dart';

class GetFotoDgpByDocumentoUseCase {
  final FotoDgpRepository repository;

  GetFotoDgpByDocumentoUseCase({required this.repository});

  Future<DataFoto> call({required String documento}) {
    return repository.getFotoByDocumento(documento: documento);
  }
}
