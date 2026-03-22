import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modules = [
      {'name': 'Notes', 'icon': Icons.note, 'route': '/notes'},
      {'name': 'Mileage', 'icon': Icons.directions_car, 'route': '/mileage'},
      {'name': 'Calendar', 'icon': Icons.calendar_today, 'route': '/calendar'},
      {'name': 'Projects', 'icon': Icons.assignment, 'route': '/projects'},
      {'name': 'Clients', 'icon': Icons.people, 'route': '/clients'},
      {'name': 'Worker Hours', 'icon': Icons.schedule, 'route': '/worker_hours'},
      {'name': 'Quotes', 'icon': Icons.quote_rounded, 'route': '/quotes'},
      {'name': 'Invoices', 'icon': Icons.receipt, 'route': '/invoices'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Oneapptredie')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, module['route']),
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(module['icon'] as IconData, size: 48, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(module['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
