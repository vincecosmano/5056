class Invoice {
  final String id;
  final String clientId;
  final String projectId;
  final String quoteId;
  final List<String> items;
  final double totalAmount;
  final String status;
  final DateTime dueDate;
  final DateTime? paidDate;

  Invoice({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.quoteId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.dueDate,
    this.paidDate,
  });
}