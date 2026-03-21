class Project {
  final String id;
  final String name;
  final String description;
  final String clientId;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final double budget;
  final double spent;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.clientId,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.budget,
    required this.spent,
  });
}