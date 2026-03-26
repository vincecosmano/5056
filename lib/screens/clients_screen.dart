import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Client Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Client Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      context.read<ClientProvider>().addClient(
                            _nameController.text,
                            _emailController.text,
                          );
                      _nameController.clear();
                      _emailController.clear();
                    }
                  },
                  child: const Text('Add Client'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ClientProvider>(
              builder: (context, clientProvider, child) {
                if (clientProvider.clients.isEmpty) {
                  return const Center(
                    child: Text('No clients yet'),
                  );
                }
                return ListView.builder(
                  itemCount: clientProvider.clients.length,
                  itemBuilder: (context, index) {
                    final client = clientProvider.clients[index];
                    return ListTile(
                      title: Text(client.name),
                      subtitle: Text(client.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          clientProvider.removeClient(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
