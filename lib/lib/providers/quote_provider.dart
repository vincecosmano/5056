import 'package:flutter/material.dart';

class QuoteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _quotes = [];

  List<Map<String, dynamic>> get quotes => _quotes;

  void addQuote(String clientName, String description, double amount) {
    _quotes.add({
      'id': DateTime.now().toString(),
      'clientName': clientName,
      'description': description,
      'amount': amount,
      'createdAt': DateTime.now(),
      'status': 'Draft',
    });
    notifyListeners();
  }

  void updateQuote(String id, String clientName, String description, double amount) {
    final index = _quotes.indexWhere((quote) => quote['id'] == id);
    if (index != -1) {
      _quotes[index] = {
        'id': id,
        'clientName': clientName,
        'description': description,
        'amount': amount,
        'createdAt': _quotes[index]['createdAt'],
        'status': _quotes[index]['status'],
      };
      notifyListeners();
    }
  }

  void deleteQuote(String id) {
    _quotes.removeWhere((quote) => quote['id'] == id);
    notifyListeners();
  }

  void setQuoteStatus(String id, String status) {
    final index = _quotes.indexWhere((quote) => quote['id'] == id);
    if (index != -1) {
      _quotes[index]['status'] = status;
      notifyListeners();
    }
  }
}
