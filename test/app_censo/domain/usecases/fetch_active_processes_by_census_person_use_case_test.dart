// Importamos el framework de testing de Flutter
import 'package:flutter_test/flutter_test.dart';

// Importamos mocktail para crear mocks y simular dependencias en tests
import 'package:mocktail/mocktail.dart';

// Importamos las clases reales de tu proyecto necesarias para el test
import 'package:siipnemovil2/app_censo/data/models/models_censo.dart';
import 'package:siipnemovil2/app_censo/domain/repositories/domain_repositories.dart';
import 'package:siipnemovil2/app_censo/domain/request/request_censo.dart';
import 'package:siipnemovil2/app_censo/domain/usecases/censo_use_cases.dart';

// Creamos una clase Mock que simula el repositorio real
// Esto nos permite controlar qué devuelve sin usar la implementación real
class MockCensoRepository extends Mock implements CensoRepository {}

void main() {
  // Declaramos variables para el caso de uso y el mock del repositorio
  late FetchActiveProcessesByCensusPersonUseCase useCase;
  late MockCensoRepository mockRepository;

  // Creamos un objeto request con datos fijos para usar en el test
  final testRequest = GetDatosProcesosActivosRequest(
       idGenPersonaCensado: 1,
  );

  // Datos de prueba que el mock devolverá simulando una respuesta real
  final testData = [
    DataProceso(
      idGenProcesoCenso: 1,
      descProceso: 'Proceso Test',
      fechaIniProceso: '2025-08-01',
      fechaFinProceso: '2025-08-02',
      idDgpRecinto: 10,
      descRecinto: 'Recinto Test',
      idDgpMesa: 5,
      descMesa: 'Mesa 1',
      documento: '1234567890',
      idGenPersona: 100,
      siglas: 'SBTE',
      apenom: 'Freddy Calderón',
      idDgpPerCenso: 1,
      censado: true,
      estadoCenso: 'Activo',
      fecha: '2025-08-01',
    ),
  ];




  // Configuramos esta función para que se ejecute antes de cada test
  setUp(() {
    // Inicializamos un nuevo mock del repositorio antes de cada test
    mockRepository = MockCensoRepository();

    // Creamos el caso de uso inyectando el mock (inyección de dependencias)
    useCase = FetchActiveProcessesByCensusPersonUseCase(repository: mockRepository);
  });

  group('Use Case datos Procesos Activos Por Censado', ()
  {
    // Definimos un test con una descripción clara
    test('retorna lista de DataCensado desde el repositorio', () async {
      // Configuramos el mock para que, cuando se llame con testRequest,
      // devuelva la lista testData simulando una respuesta async
      when(() => mockRepository.getDatosProcesosActivosByCensado(request: testRequest))
          .thenAnswer((_) async => testData);

      // Ejecutamos el caso de uso con el request de prueba
      final result = await useCase.call(request: testRequest);

      // Validamos que el resultado sea igual a los datos simulados testData
      expect(result, testData);

      // Verificamos que el método del repositorio se haya llamado exactamente una vez
      // con el request esperado
      verify(() => mockRepository.getDatosProcesosActivosByCensado(request: testRequest))
          .called(1);
    });
  });
}
