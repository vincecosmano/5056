import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientId': clientId,
        'amount': amount,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Invoice.fromJson(Map<String, dynamic> j) => Invoice(
        id: j['id'] as String,
        clientId: j['clientId'] as String,
        amount: (j['amount'] as num).toDouble(),
        description: (j['description'] as String?) ?? '',
        dueDate: DateTime.parse(j['dueDate'] as String),
        status: (j['status'] as String?) ?? 'Pending',
        createdAt: DateTime.parse(j['createdAt'] as String),
      );
}

class InvoiceProvider with ChangeNotifier {
  static const _key = 'invoices';
  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  InvoiceProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _invoices = list
          .map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(_invoices.map((i) => i.toJson()).toList()));
  }

  void add(Invoice invoice) {
    _invoices.add(invoice);
    _save();
    notifyListeners();
  }

  void update(Invoice invoice) {
    final index = _invoices.indexWhere((i) => i.id == invoice.id);
    if (index >= 0) {
      _invoices[index] = invoice;
      _save();
      notifyListeners();
    }
  }

  void delete(String id) {
    _invoices.removeWhere((i) => i.id == id);
    _save();
    notifyListeners();
  }

  void setStatus(String id, String status) {
    final index = _invoices.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _invoices[index].status = status;
      _save();
      notifyListeners();
    }
  }
}
