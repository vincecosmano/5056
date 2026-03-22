import 'package:flutter/material.dart';

class InvoiceProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _invoices = [];

  List<Map<String, dynamic>> get invoices => _invoices;

  void addInvoice(Map<String, dynamic> invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  void updateInvoice(int index, Map<String, dynamic> invoice) {
    _invoices[index] = invoice;
    notifyListeners();
  }

  void deleteInvoice(int index) {
    _invoices.removeAt(index);
    notifyListeners();
  }

  void clearInvoices() {
    _invoices.clear();
    notifyListeners();
  }
}
