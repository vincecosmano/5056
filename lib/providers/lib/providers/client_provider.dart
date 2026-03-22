import 'package:flutter/foundation.dart';

class Client {
  String id;
  String name;
  String email;
  String phone;
  String address;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class ClientProvider with ChangeNotifier {
  List<Client> _clients = [];

  List<Client> get clients => _clients;

  void add(Client client) {
    _clients.add(client);
    notifyListeners();
  }

  void update(Client client) {
    final index = _clients.indexWhere((c) => c.id == client.id);
    if (index >= 0) {
      _clients[index] = client;
      notifyListeners();
    }
  }

  void delete(String id) {
    _clients.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Client? getById(String id) {
    try {
      return _clients.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
