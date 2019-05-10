import 'package:flutter/material.dart';

import '../../models/goal.dart';
import '../../models/milestone.dart';
import '../../dao/goal_dao.dart';
import '../../dao/milestone_dao.dart';

import 'package:planner_flutter/ui/milestone/create_milestone_dialog.dart';

import 'package:planner_flutter/ui/milestone/milestones.dart';

class Goals extends StatefulWidget {
  final List<Goal> goals;
  final Function deleteGoal;
  final Function getGoals;

  Goals({this.goals, this.deleteGoal, this.getGoals});

  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  List<Milestone> _milestones = [];
  final MilestoneDao _milestoneDao = MilestoneDao();
  final GoalDao _goalDao = GoalDao();

  @override
  initState() {
    super.initState();
    _getMilestones();
  }

  void _getMilestones() async {
    List<Milestone> milestonesList = await _milestoneDao.getMilestones();
    setState(() {
      _milestones = milestonesList;
    });
  }

  Color _getProgressColor(double progress) {
    Color _color;
    if (progress >= 0 && progress <= 33.3) {
      _color = Colors.red;
    } else if (progress > 33.3 && progress <= 66.6) {
      _color = Colors.yellow;
    } else {
      _color = Colors.green;
    }
    return _color;
  }

  void _showCreateDialog(BuildContext context, Goal goal) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CreateMilestoneDialog(
              currentGoal: goal, createMilestone: _createMilestone);
        });
  }

  void _createMilestone(String description, int goalId) async {
    if (await _milestoneDao.createMilestone(Milestone(
        description: description, completed: false, goalId: goalId))) {
      _updateGoal(goalId, total: true, completed: null);
    }
  }

  void _updateGoal(int goalId, {bool total, bool completed}) async {
    Goal goal = widget.goals.firstWhere((Goal result) => result.id == goalId);
    int completedMilestones = goal.completedMilestones;
    int totalMilestones = goal.totalMilestones;
    if (completed != null && completed) {
      completedMilestones += 1;
    } else if (completed != null && !completed) {
      completedMilestones -= 1;
    } else if (total) {
      totalMilestones += 1;
    }
    Goal newGoal = Goal(
        id: goal.id,
        title: goal.title,
        totalMilestones: totalMilestones,
        completedMilestones: completedMilestones);
    if (await _goalDao.updateGoal(newGoal)) {
      widget.getGoals();
      _getMilestones();
    }
  }

  void _updateMilestone(int milestoneId) async {
    Milestone oldMilestone =
        _milestones.firstWhere((Milestone result) => result.id == milestoneId);
    Milestone newMilestone = Milestone(
        id: oldMilestone.id,
        description: oldMilestone.description,
        completed: !oldMilestone.completed,
        goalId: oldMilestone.goalId);
    if (await _milestoneDao.updateMilestone(newMilestone)) {
      _updateGoal(newMilestone.goalId,
          total: false, completed: newMilestone.completed);
    }
  }

  Widget _buildList(Goal goal) {
    Widget _content = Text('No milestone added yet');
    List<Milestone> goalMilestones = _milestones.where((Milestone result) {
      return result.goalId == goal.id;
    }).toList();
    if (goalMilestones.isNotEmpty) {
      _content = Milestones(
        milestones: goalMilestones,
        updateMilestone: _updateMilestone,
      );
    }
    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.goals.length,
        itemBuilder: (BuildContext context, int position) {
          Goal goal = widget.goals[position];
          double progress = goal.totalMilestones == 0
              ? 0
              : ((goal.completedMilestones.toDouble() /
                      goal.totalMilestones.toDouble()) *
                  100);
          return Card(
            child: ExpansionTile(
              key: Key(goal.id.toString()),
              leading: CircleAvatar(
                backgroundColor: _getProgressColor(progress),
                radius: 24,
                child: Text(
                  '${progress.toStringAsPrecision(3)}%',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              title: Text(
                goal.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: progress == 100 ? Colors.green : Colors.black),
              ),
              children: <Widget>[
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () => widget.deleteGoal(goal),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => _showCreateDialog(context, goal),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
                  child: _buildList(goal),
                )
              ],
            ),
          );
        });
  }
}
