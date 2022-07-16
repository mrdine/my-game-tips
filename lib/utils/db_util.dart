import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  //operações com o bd SQLite
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //print('path do db: ${path.join(dbPath, 'gameTips.db')}');
    return sql.openDatabase(
      path.join(dbPath, 'gameTips.db'),
      onCreate: (db, version) async {
        //executa o ddl para criar o banco
        await db.execute(
            "CREATE TABLE jogos (id TEXT PRIMARY KEY, titulo TEXT, capaUrl TEXT)");
        return db.execute(
            'CREATE TABLE tips (id TEXT PRIMARY KEY, titulo TEXT, conteudo TEXT, categoria TEXT, gameId TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql
          .ConflictAlgorithm.replace, //se inserir algo conlfitante (substitui)
    );
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.update(
      table,
      data,
      where: "id = ?",
      whereArgs: [data['id']],
      conflictAlgorithm: sql
          .ConflictAlgorithm.replace, //se inserir algo conlfitante (substitui)
    );
  }

  static Future<void> insertAll(
      String table, List<Map<String, Object>> data) async {
    for (Map<String, Object> d in data) {
      await insert(table, d);
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DbUtil.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAll(List<String> tables) async {
    final db = await DbUtil.database();
    for (String table in tables) {
      await db.delete(table);
    }
  }

  static Future<void> deleteGameAndTips(String gameId) async {
    final db = await DbUtil.database();
    await db.delete('jogos', where: 'id = ?', whereArgs: [gameId]);
    await db.delete('tips', where: 'gameId = ?', whereArgs: [gameId]);
  }

  static Future<Map<String, dynamic>?> findById(String table, String id) async {
    final db = await DbUtil.database();
    final list = await db.query(table, where: 'id = ?', whereArgs: [id]);
    return list.isNotEmpty ? list.first : null;
  }
}
