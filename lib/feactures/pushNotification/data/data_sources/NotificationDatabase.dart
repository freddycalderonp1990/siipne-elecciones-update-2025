import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDatabase {
  NotificationDatabase._();

  static final NotificationDatabase instance = NotificationDatabase._();

  static Database? _database;

  static const String databaseName = 'notifications.db';
  static const int databaseVersion = 1;

  static const String tableNotifications = 'notifications';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {

    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
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

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    switch (oldVersion) {
      case 1:
      // Aquí irán futuras migraciones cuando aumentes la versión.
        break;
    }
  }

  /// Elimina completamente la base de datos (solo para pruebas)
  Future<void> deleteDatabaseFile() async {
    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    await deleteDatabase(path);

    _database = null;
  }

  /// Cierra la conexión con la base de datos
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}