import 'package:flutter_shopping_app_with_bloc/data/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('shopingapp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
   create table Product (
    id integer primary key autoincrement,
    title text not null,
    price toDouble
   )''');

//     await db.execute('''
// create table $Product(
//   ${'id'} integer primary key autoincrement,
//   ${'title'} text not null),
//   ${'price'} double not null,
// ''');
  }
// Insert

  Future<void> insert({required ProductItem todo}) async {
    try {
      final db = await database;
      db.insert('Product', todo.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

// Get
  Future<List<ProductItem>> getAllProducts() async {
    final db = await instance.database;

    final result = await db.query('Product');

    return result.map((json) => ProductItem.fromJson(json)).toList();
  }
}
