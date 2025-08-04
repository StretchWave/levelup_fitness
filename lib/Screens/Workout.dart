import 'package:flutter/material.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class WorkoutPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page', style: Stylebook.heading1),
        backgroundColor: ColourBook.appBarColor,
      ),
      body: Center(
        child: Text(
          'Welcome to the Workout Page',
          style: Stylebook.bodyText1,
        ),
      ),
      backgroundColor: ColourBook.backgroundColor,
      
    );
  }
}