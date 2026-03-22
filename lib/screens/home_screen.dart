import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          _buildGridItem(context, 'Module 1'),
          _buildGridItem(context, 'Module 2'),
          _buildGridItem(context, 'Module 3'),
          _buildGridItem(context, 'Module 4'),
          _buildGridItem(context, 'Module 5'),
          _buildGridItem(context, 'Module 6'),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to the corresponding module
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}