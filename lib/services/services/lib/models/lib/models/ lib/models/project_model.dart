class Project {
  final String id;
  final String clientId;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final double budget;

  Project({
    required this.id,
    required this.clientId,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.budget,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'budget': budget,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      clientId: map['clientId'],
      name: map['name'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      status: map['status'],
      budget: map['budget'],
    );
  }
}
