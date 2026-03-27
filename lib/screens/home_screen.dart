import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const List<_ModuleItem> _modules = [
    _ModuleItem(
      title: 'Notes',
      subtitle: 'Appunti e promemoria',
      icon: Icons.note_alt_outlined,
      route: '/notes',
    ),
    _ModuleItem(
      title: 'Projects',
      subtitle: 'Gestione progetti',
      icon: Icons.folder_outlined,
      route: '/projects',
    ),
    _ModuleItem(
      title: 'Clients',
      subtitle: 'Rubrica clienti',
      icon: Icons.people_outlined,
      route: '/clients',
    ),
    _ModuleItem(
      title: 'Invoices',
      subtitle: 'Fatture emesse',
      icon: Icons.receipt_long_outlined,
      route: '/invoices',
    ),
    _ModuleItem(
      title: 'Worker Hours',
      subtitle: 'Ore lavorate',
      icon: Icons.access_time_outlined,
      route: '/worker_hours',
    ),
    _ModuleItem(
      title: 'Calendar',
      subtitle: 'Agenda eventi',
      icon: Icons.calendar_month_outlined,
      route: '/calendar',
    ),
    _ModuleItem(
      title: 'Quotes',
      subtitle: 'Preventivi',
      icon: Icons.request_quote_outlined,
      route: '/quotes',
    ),
    _ModuleItem(
      title: 'Mileage',
      subtitle: 'Chilometri percorsi',
      icon: Icons.directions_car_outlined,
      route: '/mileage',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oneapptredie'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: _modules.length,
        itemBuilder: (context, index) {
          return _buildGridItem(context, _modules[index]);
        },
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, _ModuleItem module) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(context, module.route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(module.icon, size: 40, color: colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                module.title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                module.subtitle,
                style: TextStyle(
                    fontSize: 11, color: colorScheme.onSurface.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  const _ModuleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}
