class Quote {
  final String id;
  final String clientId;
  final String projectId;
  final List<String> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? expiryDate;
  final DateTime? convertedToInvoiceDate;

  Quote({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.expiryDate,
    this.convertedToInvoiceDate,
  });
}