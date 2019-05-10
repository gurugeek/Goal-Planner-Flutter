import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../utils/database_util.dart';

import 'package:planner_flutter/models/goal.dart';

import './i_goal.dart';

class GoalDao implements IGoal {
  Database _db;

  Future<Database> initializeDb() async {
    if (_db == null) {
      _db = await DatabaseUtil().database;
    }
    return _db;
  }

  @override
  Future<bool> createGoal(Goal goal) async {
    await initializeDb();
    int result = await _db.insert('goal', Goal.toMap(goal));
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteGoal(Goal goal) async {
    await initializeDb();
    int result =
        await _db.delete('goal', where: 'id = ?', whereArgs: [goal.id]);
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Goal> getGoal(Goal goal) async {
    return null;
  }

  @override
  Future<List<Goal>> getGoals() async {
    await initializeDb();
    final List<Goal> goals = [];
    List<Map<String, dynamic>> result =
        await _db.rawQuery('SELECT * FROM goal');
    result.forEach((Map<String, dynamic> goal) {
      goals.add(Goal.fromMap(goal));
    });
    return goals.toList();
  }

  @override
  Future<bool> updateGoal(Goal goal) async {
    await initializeDb();
    int result = await _db.update('goal', Goal.toMap(goal),
        where: 'id = ?', whereArgs: [goal.id]);
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }
}
