import 'package:flutter/material.dart';

class AgilityScreen extends StatelessWidget {
  const AgilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strength Training', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Text('Strength Training Content Goes Here'),
      ),
    );
  }
}