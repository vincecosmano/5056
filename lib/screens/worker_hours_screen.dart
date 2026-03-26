import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/worker_hours_provider.dart';

class WorkerHoursScreen extends StatefulWidget {
  const WorkerHoursScreen({Key? key}) : super(key: key);

  @override
  State<WorkerHoursScreen> createState() => _WorkerHoursScreenState();
}

class _WorkerHoursScreenState extends State<WorkerHoursScreen> {
  final _workerIdController = TextEditingController();
  final _hoursController = TextEditingController();
  final _descController = TextEditingController();
  final _rateController = TextEditingController();
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
        title: const Text('Worker Hours'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _workerIdController,
                  decoration: const InputDecoration(
                    labelText: 'Worker name / ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _hoursController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Hours worked',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Hourly rate (€)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
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
                    final hours = double.tryParse(_hoursController.text) ?? 0;
                    final rate = double.tryParse(_rateController.text) ?? 0;
                    if (_workerIdController.text.isNotEmpty && hours > 0) {
                      context.read<WorkerHoursProvider>().addWorkerHours(
                            _workerIdController.text,
                            hours,
                            _selectedDate,
                            _descController.text,
                            rate,
                          );
                      _workerIdController.clear();
                      _hoursController.clear();
                      _descController.clear();
                      _rateController.clear();
                    }
                  },
                  child: const Text('Add Entry'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<WorkerHoursProvider>(
              builder: (context, provider, child) {
                if (provider.workerHours.isEmpty) {
                  return const Center(child: Text('No entries yet'));
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Total hours: ${provider.getTotalHours().toStringAsFixed(1)}'),
                          Text(
                              'Total cost: €${provider.getTotalCost().toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.workerHours.length,
                        itemBuilder: (context, index) {
                          final entry = provider.workerHours[index];
                          final date = entry['date'] as DateTime;
                          return ListTile(
                            title: Text(entry['workerId'] as String),
                            subtitle: Text(
                                '${entry['hoursWorked']}h @ €${entry['hourlyRate']}/h — ${date.toLocal().toString().split(' ')[0]}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    '€${(entry['totalCost'] as double).toStringAsFixed(2)}'),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => provider
                                      .deleteWorkerHours(entry['id'] as String),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
    _workerIdController.dispose();
    _hoursController.dispose();
    _descController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}
