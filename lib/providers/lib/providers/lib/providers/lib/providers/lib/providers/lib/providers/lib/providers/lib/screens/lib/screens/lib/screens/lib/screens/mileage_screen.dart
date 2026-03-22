import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mileage_provider.dart';

class MileageScreen extends StatefulWidget {
  const MileageScreen({Key? key}) : super(key: key);

  @override
  State<MileageScreen> createState() => _MileageScreenState();
}

class _MileageScreenState extends State<MileageScreen> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();

  @override
  void dispose() {
    _distanceController.dispose();
    _startLocationController.dispose();
    _endLocationController.dispose();
    super.dispose();
  }

  void _addMileage() {
    if (_distanceController.text.isEmpty ||
        _startLocationController.text.isEmpty ||
        _endLocationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<MileageProvider>().addMileage({
      'distance': double.parse(_distanceController.text),
      'startLocation': _startLocationController.text,
      'endLocation': _endLocationController.text,
      'date': DateTime.now().toString(),
    });

    _distanceController.clear();
    _startLocationController.clear();
    _endLocationController.clear();
    Navigator.pop(context);
  }

  void _showAddMileageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Mileage'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Distance (km)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _startLocationController,
              decoration: const InputDecoration(labelText: 'Start Location'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _endLocationController,
              decoration: const InputDecoration(labelText: 'End Location'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: _addMileage, child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mileage Tracking')),
      body: Consumer<MileageProvider>(
        builder: (context, mileageProvider, _) {
          double totalMileage = mileageProvider.mileageRecords
              .fold(0.0, (sum, record) => sum + (record['distance'] ?? 0.0));

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                child: Text(
                  'Total: ${totalMileage.toStringAsFixed(2)} km',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: mileageProvider.mileageRecords.isEmpty
                    ? const Center(child: Text('No mileage records yet.'))
                    : ListView.builder(
                        itemCount: mileageProvider.mileageRecords.length,
                        itemBuilder: (context, index) {
                          final record = mileageProvider.mileageRecords[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text('${record['distance']} km'),
                              subtitle: Text('${record['startLocation']} → ${record['endLocation']}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => mileageProvider.deleteMileage(index),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMileageDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
