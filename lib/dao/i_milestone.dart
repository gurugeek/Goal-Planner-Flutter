import '../models/milestone.dart';

abstract class IMilestone {
  Future<List<Milestone>> getMilestones();

  Future<bool> createMilestone(Milestone milestone);

  Future<Milestone> getMilestone(Milestone milestone);

  Future<bool> updateMilestone(Milestone milestone);

  Future<bool> deleteMilestone(Milestone milestone);
}
