import 'package:flutter/material.dart';

class Goal {
  final int id;
  final String title;
  final int totalMilestones;
  final int completedMilestones;

  Goal(
      {this.id,
      @required this.title,
      @required this.totalMilestones,
      @required this.completedMilestones});

  static Map<String, dynamic> toMap(Goal goal) {
    Map<String, dynamic> map = Map();
    if (goal.id != null) {
      map['id'] = goal.id;
    }
    map['title'] = goal.title;
    map['totalMilestones'] = goal.totalMilestones;
    map['completedMilestones'] = goal.completedMilestones;
    return map;
  }

  static Goal fromMap(Map<String, dynamic> goal) {
    return Goal(
        id: goal['id'],
        title: goal['title'],
        totalMilestones: goal['totalMilestones'],
        completedMilestones: goal['completedMilestones']);
  }
}
