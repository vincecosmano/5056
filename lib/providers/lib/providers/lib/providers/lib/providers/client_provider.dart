import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  List<Map<String, dynamic>> _clients = [];

  List<Map<String, dynamic>> get clients => _clients;

  void addClient(String name, String email, String phone, String address) {
    _clients.add({
      'id': DateTime.now().toString(),
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'createdAt': DateTime.now(),
    });
    notifyListeners();
  }

  void updateClient(String id, String name, String email, String phone, String address) {
    final index = _clients.indexWhere((client) => client['id'] == id);
    if (index != -1) {
      _clients[index] = {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'createdAt': _clients[index]['createdAt'],
      };
      notifyListeners();
    }
  }

  void deleteClient(String id) {
    _clients.removeWhere((client) => client['id'] == id);
    notifyListeners();
  }

  Map<String, dynamic>? getClientById(String id) {
    try {
      return _clients.firstWhere((client) => client['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
