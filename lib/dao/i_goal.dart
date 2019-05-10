import '../models/goal.dart';

abstract class IGoal {
  Future<List<Goal>> getGoals();

  Future<bool> createGoal(Goal goal);

  Future<Goal> getGoal(Goal goal);

  Future<bool> updateGoal(Goal goal);

  Future<bool> deleteGoal(Goal goal);
}
