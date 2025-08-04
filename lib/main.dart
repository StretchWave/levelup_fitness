import 'package:flutter/material.dart';
//import 'package:levelup_fitness/Screens/Home.dart';
import 'package:levelup_fitness/Screens/lock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
