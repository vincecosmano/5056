import 'package:flutter/material.dart';

class QuoteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _quotes = [];

  List<Map<String, dynamic>> get quotes => _quotes;

  void addQuote(Map<String, dynamic> quote) {
    _quotes.add(quote);
    notifyListeners();
  }

  void updateQuote(int index, Map<String, dynamic> quote) {
    _quotes[index] = quote;
    notifyListeners();
  }

  void deleteQuote(int index) {
    _quotes.removeAt(index);
    notifyListeners();
  }

  void clearQuotes() {
    _quotes.clear();
    notifyListeners();
  }
}
