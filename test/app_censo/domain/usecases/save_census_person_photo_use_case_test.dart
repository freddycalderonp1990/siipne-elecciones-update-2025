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
  late SaveCensusPersonPhotoUseCase useCase;
  late MockCensoRepository mockRepository;

  // Creamos un objeto request con datos fijos para usar en el test
  final testRequest = UpdateFotoPerCensoRequest(
    idDgpPerCenso: 1,
    idUsuarioCensista: 1,
    nameFotografia: "fotoCenso1.jpg",
    latitud: -0.196839,
    longitud: -78.5115531,
    ip: "local ip", gradoCensista: 'SBTE',
  );

  // Datos de prueba que el mock devolverá simulando una respuesta real
  final bool testData = true;

  // Configuramos esta función para que se ejecute antes de cada test
  setUp(() {
    // Inicializamos un nuevo mock del repositorio antes de cada test
    mockRepository = MockCensoRepository();

    // Creamos el caso de uso inyectando el mock (inyección de dependencias)
    useCase = SaveCensusPersonPhotoUseCase(repository: mockRepository);
  });

  group('Use Case Guardar Foto - TEST', () {
    // Definimos un test con una descripción clara
    test('retorna true o false', () async {
      // Configuramos el mock para que, cuando se llame con testRequest,
      // devuelva la lista testData simulando una respuesta async
      when(
        () => mockRepository.updateFoto(request: testRequest),
      ).thenAnswer((_) async => testData);

      // Ejecutamos el caso de uso con el request de prueba
      final result = await useCase.call(request: testRequest);

      // Validamos que el resultado sea igual a los datos simulados testData
      expect(result, testData);

      // Verificamos que el método del repositorio se haya llamado exactamente una vez
      // con el request esperado
      verify(() => mockRepository.updateFoto(request: testRequest)).called(1);
    });
  });
}
