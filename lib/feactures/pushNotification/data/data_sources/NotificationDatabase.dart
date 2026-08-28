// Convierte datos entre bytes y texto Base64 para generar la clave.
import 'dart:convert';

// Permite trabajar directamente con archivos, para eliminar la base anterior.
import 'dart:io';

// Permite generar valores aleatorios criptográficamente seguros.
import 'dart:math';

// Permite almacenar la clave de cifrado de forma segura en el dispositivo.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Permite construir rutas correctas para la base de datos.
import 'package:path/path.dart';

// SQLite con SQLCipher para cifrar la base de datos.
import 'package:sqflite_sqlcipher/sqflite.dart';

class NotificationDatabase {
  // Constructor privado para implementar el patrón Singleton.
  NotificationDatabase._();

  // Instancia única de la base de datos.
  static final NotificationDatabase instance = NotificationDatabase._();

  // Mantiene la conexión actual con la base de datos.
  static Database? _database;

  // Nombre, versión y tabla principal de la base de datos.
  static const String databaseName = 'notifications.db';
  static const int databaseVersion = 1;
  static const String tableNotifications = 'notifications';

  // Claves utilizadas para almacenar la contraseña y controlar
  // la eliminación única de la antigua base sin cifrar.
  static const String _databaseKeyName = 'notifications_database_key';
  static const String _migrationCompletedKey =
      'notifications_sqlcipher_migration_completed';

  // Instancia para almacenar información de forma segura en el dispositivo.
  static const FlutterSecureStorage _secureStorage =
  FlutterSecureStorage();

  // Obtiene la base de datos. Si ya está abierta, reutiliza la conexión;
  // caso contrario, la inicializa.
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;

    _database = await _initDB();
    return _database!;
  }

  // Inicializa la base de datos cifrada.
  Future<Database> _initDB() async {
    // Obtiene la ruta donde se almacenará notifications.db.
    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    // En la primera actualización elimina la antigua base sin cifrar.
    await _removeOldUnencryptedDatabase(path);

    // Obtiene la clave existente o genera una nueva de forma segura.
    final password = await _getOrCreateDatabasePassword();

    // Abre o crea la base utilizando SQLCipher y la clave de cifrado.
    return await openDatabase(
      path,
      password: password,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Elimina una sola vez la base creada anteriormente sin cifrado.
  // Las notificaciones pueden volver a descargarse, por lo que no es
  // necesario migrar la información de la base anterior.
  Future<void> _removeOldUnencryptedDatabase(String path) async {
    // Verifica si ya se realizó el proceso de migración.
    final migrationCompleted = await _secureStorage.read(
      key: _migrationCompletedKey,
    );

    // Si ya se realizó, no elimina nuevamente la base cifrada.
    if (migrationCompleted == 'true') return;

    // Elimina el archivo principal de la antigua base SQLite.
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    // Elimina el archivo WAL, si existe.
    final walFile = File('$path-wal');
    if (await walFile.exists()) {
      await walFile.delete();
    }

    // Elimina el archivo SHM, si existe.
    final shmFile = File('$path-shm');
    if (await shmFile.exists()) {
      await shmFile.delete();
    }

    // Marca que la migración ya fue realizada para evitar
    // eliminar la nueva base cifrada en futuras ejecuciones.
    await _secureStorage.write(
      key: _migrationCompletedKey,
      value: 'true',
    );
  }

  // Obtiene la clave existente o genera una nueva si es la primera ejecución.
  Future<String> _getOrCreateDatabasePassword() async {
    // Busca una clave previamente guardada.
    final existingPassword = await _secureStorage.read(
      key: _databaseKeyName,
    );

    // Si existe una clave, la utiliza para abrir la misma base cifrada.
    if (existingPassword != null && existingPassword.isNotEmpty) {
      return existingPassword;
    }

    // Genera números aleatorios utilizando un generador seguro.
    final random = Random.secure();

    // Genera una clave aleatoria de 32 bytes.
    final bytes = List<int>.generate(
      32,
          (_) => random.nextInt(256),
    );

    // Convierte los bytes en una cadena Base64 compatible con una contraseña.
    final password = base64UrlEncode(bytes);

    // Guarda la clave de forma segura para futuras ejecuciones.
    await _secureStorage.write(
      key: _databaseKeyName,
      value: password,
    );

    return password;
  }

  // Se ejecuta únicamente cuando la base de datos se crea por primera vez.
  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    // Crea la tabla donde se almacenan las notificaciones.
    await db.execute('''
      CREATE TABLE $tableNotifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idGenUsuario INTEGER NOT NULL,
        accion TEXT NOT NULL,
        appName TEXT NOT NULL,
        idAccion TEXT NOT NULL,
        body TEXT NOT NULL,
        title TEXT NOT NULL,
        clickAction TEXT NOT NULL,
        fecha TEXT NOT NULL,
        leida INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // Se ejecutará cuando aumente la versión de la base de datos.
  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    switch (oldVersion) {
      case 1:
      // Aquí se agregarán futuras migraciones de la estructura de la BD.
        break;
    }
  }

  // Elimina completamente la base de datos y su clave de cifrado.
  // Debe utilizarse únicamente cuando se requiera reiniciar la base desde cero.
  Future<void> deleteDatabaseFile() async {
    // Cierra primero la conexión activa.
    await close();

    // Obtiene la ruta de la base.
    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    // Elimina el archivo principal de la base cifrada.
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    // Elimina archivos auxiliares de SQLite, si existen.
    final walFile = File('$path-wal');
    if (await walFile.exists()) {
      await walFile.delete();
    }

    final shmFile = File('$path-shm');
    if (await shmFile.exists()) {
      await shmFile.delete();
    }

    // Elimina la clave para que, al crear nuevamente la base,
    // se genere una nueva clave de cifrado.
    await _secureStorage.delete(
      key: _databaseKeyName,
    );

    _database = null;
  }

  // Cierra la conexión actual con la base de datos.
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }

    // Elimina la referencia para permitir una nueva apertura posteriormente.
    _database = null;
  }
}