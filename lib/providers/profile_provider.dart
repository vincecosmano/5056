import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  static const _key = 'user_profile';

  String _name = '';
  String _email = '';
  String _phone = '';
  String _company = '';
  String _vatNumber = '';
  String _address = '';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get company => _company;
  String get vatNumber => _vatNumber;
  String get address => _address;

  ProfileProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final m = jsonDecode(raw) as Map<String, dynamic>;
      _name = (m['name'] as String?) ?? '';
      _email = (m['email'] as String?) ?? '';
      _phone = (m['phone'] as String?) ?? '';
      _company = (m['company'] as String?) ?? '';
      _vatNumber = (m['vatNumber'] as String?) ?? '';
      _address = (m['address'] as String?) ?? '';
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode({
        'name': _name,
        'email': _email,
        'phone': _phone,
        'company': _company,
        'vatNumber': _vatNumber,
        'address': _address,
      }),
    );
  }

  Future<void> update({
    required String name,
    required String email,
    required String phone,
    required String company,
    required String vatNumber,
    required String address,
  }) async {
    _name = name;
    _email = email;
    _phone = phone;
    _company = company;
    _vatNumber = vatNumber;
    _address = address;
    await _save();
    notifyListeners();
  }
}
