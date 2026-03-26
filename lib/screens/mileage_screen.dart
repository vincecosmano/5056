import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mileage_provider.dart';

class MileageScreen extends StatefulWidget {
  const MileageScreen({Key? key}) : super(key: key);

  @override
  State<MileageScreen> createState() => _MileageScreenState();
}

class _MileageScreenState extends State<MileageScreen> {
  final _distanceController = TextEditingController();
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
        title: const Text('Mileage'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _distanceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Distance (km)',
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
                          labelText: 'Rate per km (€)',
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
                    labelText: 'Description / Vehicle',
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
                    final distance =
                        double.tryParse(_distanceController.text) ?? 0;
                    final rate = double.tryParse(_rateController.text) ?? 0;
                    if (distance > 0) {
                      context.read<MileageProvider>().addMileage(
                            distance,
                            _selectedDate,
                            _descController.text,
                            rate,
                          );
                      _distanceController.clear();
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
            child: Consumer<MileageProvider>(
              builder: (context, provider, child) {
                if (provider.mileages.isEmpty) {
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
                              'Total km: ${provider.getTotalMileage().toStringAsFixed(1)}'),
                          Text(
                              'Total cost: €${provider.getTotalMileageCost().toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.mileages.length,
                        itemBuilder: (context, index) {
                          final entry = provider.mileages[index];
                          final date = entry['date'] as DateTime;
                          return ListTile(
                            title: Text(entry['description'] as String),
                            subtitle: Text(
                                '${entry['distance']} km @ €${entry['ratePerKm']}/km — ${date.toLocal().toString().split(' ')[0]}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    '€${(entry['totalCost'] as double).toStringAsFixed(2)}'),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => provider.deleteMileage(
                                      entry['id'] as String),
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
    _distanceController.dispose();
    _descController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}