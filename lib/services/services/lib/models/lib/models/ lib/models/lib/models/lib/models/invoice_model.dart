class Invoice {
  final String id;
  final String clientId;
  final String projectId;
  final String invoiceNumber;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? paidDate;

  Invoice({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.invoiceNumber,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.dueDate,
    this.paidDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'projectId': projectId,
      'invoiceNumber': invoiceNumber,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'paidDate': paidDate?.toIso8601String(),
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'],
      clientId: map['clientId'],
      projectId: map['projectId'],
      invoiceNumber: map['invoiceNumber'],
      totalAmount: map['totalAmount'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      paidDate: map['paidDate'] != null ? DateTime.parse(map['paidDate']) : null,
    );
  }
}
