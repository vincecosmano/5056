import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final _clientController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
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
                    labelText: 'Client name',
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
                ElevatedButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(_amountController.text) ?? 0;
                    if (_clientController.text.isNotEmpty) {
                      context.read<QuoteProvider>().addQuote(
                            _clientController.text,
                            _descController.text,
                            amount,
                          );
                      _clientController.clear();
                      _descController.clear();
                      _amountController.clear();
                    }
                  },
                  child: const Text('Add Quote'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<QuoteProvider>(
              builder: (context, provider, child) {
                if (provider.quotes.isEmpty) {
                  return const Center(child: Text('No quotes yet'));
                }
                return ListView.builder(
                  itemCount: provider.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = provider.quotes[index];
                    return ListTile(
                      title: Text(quote['clientName'] as String),
                      subtitle: Text(quote['description'] as String),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '€${(quote['amount'] as double).toStringAsFixed(2)}'),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => provider
                                .deleteQuote(quote['id'] as String),
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