

import '../../data/models/foto_model.dart';


abstract class FotoDgpRepository {
  Future<DataFoto> getFotoByDocumento({required String documento});

}
