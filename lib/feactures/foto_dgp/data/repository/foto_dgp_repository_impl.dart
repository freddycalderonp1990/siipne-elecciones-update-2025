


import 'package:siipnemovil2/feactures/foto_dgp/data/models/foto_model.dart';

import '../../domain/repository/foto_dgp_repository.dart';
import '../datasources/foto_dgp_remote_data_source.dart';

class FotoDgpRepositoryImpl implements FotoDgpRepository {
  final FotoDgpRemoteDataSource fotoDgpRemoteDataSource;

  FotoDgpRepositoryImpl({required this.fotoDgpRemoteDataSource});

  @override
  Future<DataFoto> getFotoByDocumento({required String documento}) async {
    return fotoDgpRemoteDataSource.getFotoByDocumento(documento: documento);
  }


}
