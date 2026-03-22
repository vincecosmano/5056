import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _clients = [];

  List<Map<String, dynamic>> get clients => _clients;

  void addClient(Map<String, dynamic> client) {
    _clients.add(client);
    notifyListeners();
  }

  void updateClient(int index, Map<String, dynamic> client) {
    _clients[index] = client;
    notifyListeners();
  }

  void deleteClient(int index) {
    _clients.removeAt(index);
    notifyListeners();
  }

  void clearClients() {
    _clients.clear();
    notifyListeners();
  }
}
