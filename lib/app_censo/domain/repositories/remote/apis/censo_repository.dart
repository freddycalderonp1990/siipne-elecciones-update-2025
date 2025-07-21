part of '../../domain_repositories.dart';



abstract class CensoRepository {
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<DataCensado> getDatosPersonaCenso({
    required GetDatosPersonaCensoRequest request,
  });



}
