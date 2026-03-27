import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      };

  factory Client.fromJson(Map<String, dynamic> j) => Client(
        id: j['id'] as String,
        name: j['name'] as String,
        email: (j['email'] as String?) ?? '',
        phone: (j['phone'] as String?) ?? '',
        address: (j['address'] as String?) ?? '',
      );
}

class ClientProvider with ChangeNotifier {
  static const _key = 'clients';
  List<Client> _clients = [];

  List<Client> get clients => _clients;

  ClientProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _clients = list
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(_clients.map((c) => c.toJson()).toList()));
  }

  void add(Client client) {
    _clients.add(client);
    _save();
    notifyListeners();
  }

  void addClient(String name, String email) {
    final newClient = Client(
      id: '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(999999)}',
      name: name,
      email: email,
      phone: '',
      address: '',
    );
    _clients.add(newClient);
    _save();
    notifyListeners();
  }

  void update(Client client) {
    final index = _clients.indexWhere((c) => c.id == client.id);
    if (index >= 0) {
      _clients[index] = client;
      _save();
      notifyListeners();
    }
  }

  void delete(String id) {
    _clients.removeWhere((c) => c.id == id);
    _save();
    notifyListeners();
  }

  void removeClient(int index) {
    if (index >= 0 && index < _clients.length) {
      _clients.removeAt(index);
      _save();
      notifyListeners();
    }
  }

  Client? getById(String id) {
    try {
      return _clients.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
