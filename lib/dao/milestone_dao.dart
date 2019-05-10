import 'package:sqflite/sqflite.dart';

import '../utils/database_util.dart';

import 'package:planner_flutter/models/milestone.dart';

import './i_milestone.dart';

class MilestoneDao implements IMilestone {
  Database _db;

  Future<Database> initializeDb() async {
    if (_db == null) {
      _db = await DatabaseUtil().database;
    }
    return _db;
  }

  @override
  Future<bool> createMilestone(Milestone milestone) async {
    await initializeDb();
    int result = await _db.insert('milestone', Milestone.toMap(milestone));
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteMilestone(Milestone milestone) async {
    await initializeDb();
    int result = await _db
        .delete('milestone', where: 'id = ?', whereArgs: [milestone.id]);
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Milestone> getMilestone(Milestone milestone) async {
    // TODO: implement getMilestone
    return null;
  }

  @override
  Future<List<Milestone>> getMilestones() async {
    await initializeDb();
    final List<Milestone> milestones = [];
    List<Map<String, dynamic>> result =
        await _db.rawQuery('SELECT * FROM milestone');
    result.forEach((Map<String, dynamic> milestone) {
      milestones.add(Milestone.fromMap(milestone));
    });
    return milestones.toList();
  }

  @override
  Future<bool> updateMilestone(Milestone milestone) async {
    await initializeDb();
    int result = await _db.update('milestone', Milestone.toMap(milestone),
        where: 'id = ?', whereArgs: [milestone.id]);
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }
}
