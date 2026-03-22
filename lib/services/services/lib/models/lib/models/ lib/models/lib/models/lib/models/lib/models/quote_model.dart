class Quote {
  final String id;
  final String clientId;
  final String projectId;
  final double amount;
  final String status;
  final String description;
  final DateTime createdAt;
  final DateTime? expiryDate;

  Quote({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.amount,
    required this.status,
    required this.description,
    required this.createdAt,
    this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'projectId': projectId,
      'amount': amount,
      'status': status,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      clientId: map['clientId'],
      projectId: map['projectId'],
      amount: map['amount'],
      status: map['status'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      expiryDate: map['expiryDate'] != null ? DateTime.parse(map['expiryDate']) : null,
    );
  }
}
