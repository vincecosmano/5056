import 'package:flutter/material.dart';

class WorkerHoursScreen extends StatefulWidget {
  @override
  _WorkerHoursScreenState createState() => _WorkerHoursScreenState();
}

class _WorkerHoursScreenState extends State<WorkerHoursScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Hours'),
      ),
      body: Center(
        child: Text('Worker hours will be displayed here'),
      ),
    );
  }
}
