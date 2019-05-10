class SqlUtils {
  static String goalTableSql = 'CREATE TABLE goal(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(50) NOT NULL, totalMilestones INTEGER NOT NULL, completedMilestones INTEGER NOT NULL)';
  static String milestoneTableSql = 'CREATE TABLE milestone(id INTEGER PRIMARY KEY AUTOINCREMENT, description VARCHAR(100) NOT NULL, completed INTEGER NOT NULL, goalId INTEGER NOT NULL)';
}