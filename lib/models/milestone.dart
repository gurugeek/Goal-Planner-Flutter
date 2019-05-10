import 'package:flutter/material.dart';

class Milestone {
  final int id;
  final String description;
  final bool completed;
  final int goalId;

  Milestone(
      {this.id,
      @required this.description,
      @required this.completed,
      @required this.goalId});

  static Map<String, dynamic> toMap(Milestone milestone) {
    Map<String, dynamic> map = Map();
    if (milestone.id != null) {
      map['id'] = milestone.id;
    }
    map['description'] = milestone.description;
    map['completed'] = milestone.completed ? 1 : 0;
    map['goalId'] = milestone.goalId;
    return map;
  }

  static Milestone fromMap(Map<String, dynamic> milestone) {
    final _isCompleted = milestone['completed'] == 0 ? false : true;
    return Milestone(
        id: milestone['id'],
        description: milestone['description'],
        completed: _isCompleted,
        goalId: milestone['goalId']);
  }
}
