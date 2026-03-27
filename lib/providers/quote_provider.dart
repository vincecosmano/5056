import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteProvider with ChangeNotifier {
  static const _key = 'quotes';
  List<Map<String, dynamic>> _quotes = [];

  List<Map<String, dynamic>> get quotes => _quotes;

  QuoteProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _quotes = list.map((e) {
        final m = Map<String, dynamic>.from(e as Map);
        m['amount'] = (m['amount'] as num).toDouble();
        m['createdAt'] = DateTime.parse(m['createdAt'] as String);
        return m;
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final serializable = _quotes.map((q) {
      final m = Map<String, dynamic>.from(q);
      if (m['createdAt'] is DateTime) {
        m['createdAt'] = (m['createdAt'] as DateTime).toIso8601String();
      }
      return m;
    }).toList();
    await prefs.setString(_key, jsonEncode(serializable));
  }

  void addQuote(String clientName, String description, double amount) {
    _quotes.add({
      'id': DateTime.now().toString(),
      'clientName': clientName,
      'description': description,
      'amount': amount,
      'createdAt': DateTime.now(),
      'status': 'Draft',
    });
    _save();
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
      _save();
      notifyListeners();
    }
  }

  void deleteQuote(String id) {
    _quotes.removeWhere((quote) => quote['id'] == id);
    _save();
    notifyListeners();
  }

  void setQuoteStatus(String id, String status) {
    final index = _quotes.indexWhere((quote) => quote['id'] == id);
    if (index != -1) {
      _quotes[index]['status'] = status;
      _save();
      notifyListeners();
    }
  }
}