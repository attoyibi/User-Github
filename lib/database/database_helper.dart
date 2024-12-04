// lib/database/database_helper.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart'; // Impor model User yang sudah dibuat
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_ffi

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  // static initializeDatabase() async {
  //   // Initialize FFI for web
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'users.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            avatar_url TEXT,
            name TEXT,
            company TEXT,
            email TEXT,
            location TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Menambahkan user ke database
  Future<int> insertUser(User user) async {
    print(user);
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  // Mengambil semua pengguna favorit
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Menghapus user berdasarkan id
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
