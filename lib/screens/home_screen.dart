import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          _buildGridItem(context, 'Notes', '/notes'),
          _buildGridItem(context, 'Projects', '/projects'),
          _buildGridItem(context, 'Clients', '/clients'),
          _buildGridItem(context, 'Invoices', '/invoices'),
          _buildGridItem(context, 'Worker Hours', '/worker_hours'),
          _buildGridItem(context, 'Calendar', '/calendar'),
          _buildGridItem(context, 'Quotes', '/quotes'),
          _buildGridItem(context, 'Mileage', '/mileage'),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String route) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
