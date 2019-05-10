import 'package:flutter/material.dart';

import '../models/goal.dart';
import '../models/milestone.dart';
import '../dao/goal_dao.dart';
import '../dao/milestone_dao.dart';

import 'package:planner_flutter/ui/goal/goals.dart';
import 'package:planner_flutter/ui/goal/create_goal_dialog.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  List<Goal> _goals = [];
  GoalDao _goalDao = GoalDao();
  MilestoneDao _milestoneDao = MilestoneDao();

  @override
  void initState() {
    super.initState();
    _getGoals();
  }

  void _getGoals() async {
    List<Goal> goalList = await _goalDao.getGoals();
    setState(() {
      _goals = goalList;
    });
  }

  Widget _buildList() {
    Widget _content = Center(
      child: Text('No goals added yet'),
    );
    if (_goals.length != 0 && _goals.isNotEmpty) {
      _content =
          Goals(goals: _goals, deleteGoal: _deleteGoal, getGoals: _getGoals);
    }
    return _content;
  }

  void _createGoal(String title) async {
    if (await _goalDao.createGoal(
        Goal(title: title, totalMilestones: 0, completedMilestones: 0))) {
      _getGoals();
    }
  }

  void _deleteGoal(Goal goal) async {
    if (await _goalDao.deleteGoal(goal)) {
      List<Milestone> result = await _milestoneDao.getMilestones();
      result
          .where((Milestone milestone) => milestone.goalId == goal.id)
          .toList()
          .forEach((Milestone filtered) {
        _milestoneDao.deleteMilestone(filtered);
      });
      _getGoals();
    }
  }

  void _showCreateDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CreateGoalDialog(createGoal: _createGoal);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals Planner'),
        centerTitle: true,
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: Icon(Icons.add),
        label: Text('Add New Goal'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
