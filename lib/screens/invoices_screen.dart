import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/invoice_provider.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final _clientController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _clientController,
                  decoration: const InputDecoration(
                    labelText: 'Client ID / Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount (€)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Due date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      child: const Text('Pick date'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(_amountController.text) ?? 0;
                    if (_clientController.text.isNotEmpty) {
                      context.read<InvoiceProvider>().add(
                            Invoice(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              clientId: _clientController.text,
                              amount: amount,
                              description: _descController.text,
                              dueDate: _selectedDate,
                              status: 'Pending',
                              createdAt: DateTime.now(),
                            ),
                          );
                      _clientController.clear();
                      _descController.clear();
                      _amountController.clear();
                    }
                  },
                  child: const Text('Add Invoice'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<InvoiceProvider>(
              builder: (context, provider, child) {
                if (provider.invoices.isEmpty) {
                  return const Center(child: Text('No invoices yet'));
                }
                return ListView.builder(
                  itemCount: provider.invoices.length,
                  itemBuilder: (context, index) {
                    final invoice = provider.invoices[index];
                    return ListTile(
                      title: Text(invoice.clientId),
                      subtitle: Text(
                          '${invoice.description} — Due: ${invoice.dueDate.toLocal().toString().split(' ')[0]}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('€${invoice.amount.toStringAsFixed(2)}'),
                              Text(invoice.status,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                provider.delete(invoice.id),
                          ),
                        ],
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
    _clientController.dispose();
    _descController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}