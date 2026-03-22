class WorkerHours {
  final String id;
  final String workerId;
  final double hoursWorked;
  final DateTime date;
  final String description;
  final double hourlyRate;

  WorkerHours({
    required this.id,
    required this.workerId,
    required this.hoursWorked,
    required this.date,
    required this.description,
    required this.hourlyRate,
  });

  factory WorkerHours.fromJson(Map<String, dynamic> json) {
    return WorkerHours(
      id: json['id'] ?? '',
      workerId: json['workerId'] ?? '',
      hoursWorked: (json['hoursWorked'] ?? 0).toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      description: json['description'] ?? '',
      hourlyRate: (json['hourlyRate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'hoursWorked': hoursWorked,
      'date': date.toIso8601String(),
      'description': description,
      'hourlyRate': hourlyRate,
    };
  }

  double get totalCost => hoursWorked * hourlyRate;

  WorkerHours copyWith({
    String? id,
    String? workerId,
    double? hoursWorked,
    DateTime? date,
    String? description,
    double? hourlyRate,
  }) {
    return WorkerHours(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      date: date ?? this.date,
      description: description ?? this.description,
      hourlyRate: hourlyRate ?? this.hourlyRate,
    );
  }
}
