class WorkerHours {
  final String id;
  final String userId;
  final String projectId;
  final DateTime date;
  final DateTime clockIn;
  final DateTime? clockOut;
  final String taskDescription;

  WorkerHours({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.date,
    required this.clockIn,
    this.clockOut,
    required this.taskDescription,
  });

  double get hours {
    if (clockOut == null) return 0;
    return clockOut!.difference(clockIn).inMinutes / 60.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'projectId': projectId,
      'date': date.toIso8601String(),
      'clockIn': clockIn.toIso8601String(),
      'clockOut': clockOut?.toIso8601String(),
      'taskDescription': taskDescription,
    };
  }

  factory WorkerHours.fromMap(Map<String, dynamic> map) {
    return WorkerHours(
      id: map['id'],
      userId: map['userId'],
      projectId: map['projectId'],
      date: DateTime.parse(map['date']),
      clockIn: DateTime.parse(map['clockIn']),
      clockOut: map['clockOut'] != null ? DateTime.parse(map['clockOut']) : null,
      taskDescription: map['taskDescription'],
    );
  }
}
