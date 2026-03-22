import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/invoice_provider.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addInvoice() {
    if (_numberController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<InvoiceProvider>().addInvoice({
      'number': _numberController.text,
      'total': double.parse(_amountController.text),
      'status': 'Pending',
      'createdAt': DateTime.now().toString(),
    });

    _numberController.clear();
    _amountController.clear();
    Navigator.pop(context);
  }

  void _showAddInvoiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Invoice'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Invoice Number'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Total Amount'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: _addInvoice, child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoices')),
      body: Consumer<InvoiceProvider>(
        builder: (context, invoiceProvider, _) {
          if (invoiceProvider.invoices.isEmpty) {
            return const Center(child: Text('No invoices yet.'));
          }
          return ListView.builder(
            itemCount: invoiceProvider.invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoiceProvider.invoices[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Invoice #${invoice['number']}'),
                  subtitle: Text('\$${invoice['total']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => invoiceProvider.deleteInvoice(index),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInvoiceDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
