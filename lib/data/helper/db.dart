import 'package:fininite_riverpod/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'flicknite.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        iduser TEXT PRIMARY KEY,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  Future<int> registerUser(UserModel user) async {
    Database db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<UserModel?> loginUser(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
}
