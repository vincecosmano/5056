import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _addClient() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in required fields')),
      );
      return;
    }

    context.read<ClientProvider>().addClient({
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });

    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    Navigator.pop(context);
  }

  void _showAddClientDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Client'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Client Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: _addClient, child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: Consumer<ClientProvider>(
        builder: (context, clientProvider, _) {
          if (clientProvider.clients.isEmpty) {
            return const Center(child: Text('No clients yet.'));
          }
          return ListView.builder(
            itemCount: clientProvider.clients.length,
            itemBuilder: (context, index) {
              final client = clientProvider.clients[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(client['name']),
                  subtitle: Text(client['email']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => clientProvider.deleteClient(index),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddClientDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
Click "Commit changes"

Screen 8: lib/screens/worker_hours_screen.dart
Dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/worker_hours_provider.dart';

class WorkerHoursScreen extends StatefulWidget {
  const WorkerHoursScreen({Key? key}) : super(key: key);

  @override
  State<WorkerHoursScreen> createState() => _WorkerHoursScreenState();
}

class _WorkerHoursScreenState extends State<WorkerHoursScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Worker Hours')),
      body: Consumer<WorkerHoursProvider>(
        builder: (context, workerHoursProvider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => workerHoursProvider.toggleClockIn(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: workerHoursProvider.isClockedIn ? Colors.red : Colors.green,
                  ),
                  child: Text(
                    workerHoursProvider.isClockedIn ? 'Clock Out' : 'Clock In',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: workerHoursProvider.workerHours.isEmpty
                    ? const Center(child: Text('No hours logged yet.'))
                    : ListView.builder(
                        itemCount: workerHoursProvider.workerHours.length,
                        itemBuilder: (context, index) {
                          final hours = workerHoursProvider.workerHours[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text('${hours['hours']} hours'),
                              subtitle: Text(hours['date']),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => workerHoursProvider.deleteWorkerHours(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
