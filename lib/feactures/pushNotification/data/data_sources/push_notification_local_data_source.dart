import 'package:sqflite/sqflite.dart';

import '../models/models_push_notification.dart';
import 'NotificationDatabase.dart';

abstract class PushNotificationLocalDataSource {

  Future<List<NotificationLocalModel>> obtenerNotificaciones({
    required int idGenUsuario,
  });

  Future<int> eliminarTodas({
    required int idGenUsuario,
  });

  Future<int> obtenerCantidadNoLeidas({
    required int idGenUsuario,
  });


  Future<int> guardarNotificacion({
    required NotificationLocalModel notification,
  });


  Future<int> marcarComoLeida({
    required int id,
  });

  Future<int> eliminarNotificacion({
    required int id,
  });


}

class PushNotificationLocalDataSourceImpl
    implements PushNotificationLocalDataSource {



  final NotificationDatabase _database = NotificationDatabase.instance;

  @override
  Future<int> guardarNotificacion({
    required NotificationLocalModel notification,
  }) async {
    final db = await _database.database;

    return await db.insert(
      NotificationDatabase.tableNotifications,
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<NotificationLocalModel>> obtenerNotificaciones({
    required int idGenUsuario,
  }) async {
    final db = await _database.database;

    final maps = await db.query(
      NotificationDatabase.tableNotifications,
      where: 'idGenUsuario = ?',
      whereArgs: [idGenUsuario],
      orderBy: 'id DESC',
    );

    return List.generate(
      maps.length,
          (index) => NotificationLocalModel.fromMap(maps[index]),
    );
  }


  @override
  Future<int> marcarComoLeida({
    required int id,
  }) async {
    final db = await _database.database;

    return await db.update(
            NotificationDatabase.tableNotifications,
      {
        'leida': 1,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> eliminarNotificacion({
    required int id,
  }) async {
    final db = await _database.database;

    return await db.delete(
            NotificationDatabase.tableNotifications,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> eliminarTodas({
    required int idGenUsuario,
  }) async {
    final db = await _database.database;

    return await db.delete(
      NotificationDatabase.tableNotifications,
      where: 'idGenUsuario = ?',
      whereArgs: [idGenUsuario],
    );
  }

  @override
  Future<int> obtenerCantidadNoLeidas({
    required int idGenUsuario,
  }) async {
    final db = await _database.database;

    final result = await db.rawQuery(
      '''
    SELECT COUNT(*) as total
    FROM ${NotificationDatabase.tableNotifications}
    WHERE idGenUsuario = ?
      AND leida = 0
    ''',
      [idGenUsuario],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

}