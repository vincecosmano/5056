import 'package:flutter/material.dart';

class InvoiceProvider with ChangeNotifier {
  List<Map<String, dynamic>> _invoices = [];

  List<Map<String, dynamic>> get invoices => _invoices;

  void addInvoice(String clientId, double amount, String description, DateTime dueDate) {
    _invoices.add({
      'id': DateTime.now().toString(),
      'clientId': clientId,
      'amount': amount,
      'description': description,
      'dueDate': dueDate,
      'status': 'Pending',
      'createdAt': DateTime.now(),
    });
    notifyListeners();
  }

  void updateInvoice(String id, String clientId, double amount, String description, DateTime dueDate) {
    final index = _invoices.indexWhere((invoice) => invoice['id'] == id);
    if (index != -1) {
      _invoices[index] = {
        'id': id,
        'clientId': clientId,
        'amount': amount,
        'description': description,
        'dueDate': dueDate,
        'status': _invoices[index]['status'],
        'createdAt': _invoices[index]['createdAt'],
      };
      notifyListeners();
    }
  }

  void deleteInvoice(String id) {
    _invoices.removeWhere((invoice) => invoice['id'] == id);
    notifyListeners();
  }

  void setInvoiceStatus(String id, String status) {
    final index = _invoices.indexWhere((invoice) => invoice['id'] == id);
    if (index != -1) {
      _invoices[index]['status']
