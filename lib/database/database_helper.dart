import 'dart:io' as io;

import 'package:core_flutter/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    //when creating the db, create the table
    await db.execute('CREATE TABLE AUTH(token)');
  }

  Future<int> saveToken(Auth auth) async {
    var dbClient = await db;
    int res = await dbClient.insert("Auth", auth.toMap());
    return res;
  }

  // ignore: missing_return
  Future<int> deleteToken() async {
    try {
      var dbClient = await db;
      int res = await dbClient.delete('Auth');
      return res;
    } catch (e) {
      print(e);
    }
  }

  Future<List> getToken() async {
    var dbClient = await db;
    var result = await dbClient.query("Auth", columns: ["token"]);
    return result.toList();
  }
}
