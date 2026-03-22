import 'package:flutter/material.dart';

class QuotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: Center(
        child: Text('Manage your quotes here!'),
      ),
    );
  }
}