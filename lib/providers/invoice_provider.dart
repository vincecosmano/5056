import 'package:flutter/foundation.dart';

class Invoice {
  String id;
  String clientId;
  double amount;
  String description;
  DateTime dueDate;
  String status;
  DateTime createdAt;

  Invoice({
    required this.id,
    required this.clientId,
    required this.amount,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.createdAt,
  });
}

class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  void add(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  void update(Invoice invoice) {
    final index = _invoices.indexWhere((i) => i.id == invoice.id);
    if (index >= 0) {
      _invoices[index] = invoice;
      notifyListeners();
    }
  }

  void delete(String id) {
    _invoices.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void setStatus(String id, String status) {
    final index = _invoices.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _invoices[index].status = status;
      notifyListeners();
    }
  }
}
