import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/model.dart';


class ToDoDataBaseHelper {
  static const int _dbVersion = 1;
  static const String _dbName = "ToDo.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE MyTable(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"),
        version: _dbVersion);
  }

  static Future<int> addTodo(ToDo todo) async {
    final db = await _getDb();
    return await db.insert("MyTable", todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateToDo(ToDo todo) async {
    final db = await _getDb();
    return await db.update("MyTable", todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTodo(ToDo todo) async {
    final db = await _getDb();
    return await db.delete("MyTable", where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<List<ToDo>?> getAllToDo() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> map = await db.query("MyTable");

    if (map.isEmpty) {
      return null;
    }

    return List.generate(map.length, (index) => ToDo.fromJson(map[index]));
  }
}
