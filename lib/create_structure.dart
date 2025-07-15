//ejecutar
// dart run /Users/policianacional/AndroidStudioProjects/siipne-elecciones-update-2025/lib/create_structure.dart
import 'dart:io';

void main() {
  final basePath = 'app_censo';

  // Obtener fecha actual
  final now = DateTime.now();
  final fecha = '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';

  // Rutas base para facilitar mantenimiento
  final corePath = '$basePath/core';
  final dataPath = '$basePath/data';
  final domainPath = '$basePath/domain';
  final presentationPath = '$basePath/presentation';

  // Carpetas a crear
  final folders = [
    '$corePath/exceptions',
    '$corePath/utils',
    '$corePath/values',

    '$dataPath/datasources',
    '$dataPath/datasources/local',
    '$dataPath/datasources/remote',
    '$dataPath/models',
    '$dataPath/repositories',

    '$domainPath/entities',
    '$domainPath/repositories',
    '$domainPath/usecases',
    '$domainPath/request',

    '$presentationPath/modules',
    '$presentationPath/routes',
    '$presentationPath/widgets',
  ];

  // Archivos a crear
  final files = [
    '$corePath/${basePath}_config.dart',
    '$corePath/values/${basePath}_colors.dart',
    '$corePath/values/${basePath}_images.dart',
    '$dataPath/models/${basePath}_models.dart',
  ];

  // Crear carpetas
  for (var path in folders) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print('📁 Carpeta creada: $path');
    } else {
      print('✅ Carpeta existente: $path');
    }
  }

  // Crear archivos con encabezado automático
  for (var filePath in files) {
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      final fileName = file.uri.pathSegments.last;
      file.writeAsStringSync('''
// Archivo generado automáticamente
// Nombre: $fileName
// Fecha: $fecha

''');
      print('📄 Archivo creado: $filePath');
    } else {
      print('✅ Archivo existente: $filePath');
    }
  }

  print('\n✅ Proyecto "$basePath" generado correctamente.');
}

// Función auxiliar para formato de fecha
String _twoDigits(int n) => n.toString().padLeft(2, '0');
