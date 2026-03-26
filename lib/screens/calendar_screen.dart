import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
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
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Event title',
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
                    if (_titleController.text.isNotEmpty) {
                      context.read<CalendarProvider>().addEvent(
                            _titleController.text,
                            _descController.text,
                            _selectedDate,
                            'General',
                          );
                      _titleController.clear();
                      _descController.clear();
                    }
                  },
                  child: const Text('Add Event'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<CalendarProvider>(
              builder: (context, calendarProvider, child) {
                if (calendarProvider.events.isEmpty) {
                  return const Center(child: Text('No events yet'));
                }
                return ListView.builder(
                  itemCount: calendarProvider.events.length,
                  itemBuilder: (context, index) {
                    final event = calendarProvider.events[index];
                    final date = event['date'] as DateTime;
                    return ListTile(
                      title: Text(event['title'] as String),
                      subtitle: Text(
                          '${date.toLocal().toString().split(' ')[0]} — ${event['description']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            calendarProvider.deleteEvent(event['id'] as String),
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
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
