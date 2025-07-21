



import '../../data/models/models_censo.dart';
import '../repositories/domain_repositories.dart';
import '../request/request_censo.dart';

class GetDatosPersonaCenso {
  final CensoRepository repository;

  GetDatosPersonaCenso({required this.repository});

  Future<DataCensado> call({required GetDatosPersonaCensoRequest request }) {
    return repository.getDatosPersonaCenso(request: request);
  }
}

