import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import './sql_util.dart';

class DatabaseUtil {
  static DatabaseUtil _databaseUtil = DatabaseUtil._createInstance();
  static Database _database;

  DatabaseUtil._createInstance();

  factory DatabaseUtil() {
    if (_databaseUtil == null) {
      _databaseUtil = DatabaseUtil._createInstance();
    }
    return _databaseUtil;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, 'planner_db.db');

    Database plannerDB =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    if (plannerDB != null) {
      print('DATABASE: Success');
    } else {
      print('DATABASE: Error');
    }
    return plannerDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(SqlUtils.goalTableSql);
    await db.execute(SqlUtils.milestoneTableSql);
  }
}
