import 'package:flutter/material.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class StrengthScreen extends StatelessWidget {
  const StrengthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourBook.backgroundColor,
      appBar: AppBar(
        title: Text('Back',style: Stylebook.bodyText1,),
        backgroundColor: ColourBook.statBoxColor,
        
      ),
      body: 
        
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 250,
            color: ColourBook.statBoxColor,
            child: Center(
              child: Text(
                'Strength Training\nExercises',
                style: Stylebook.heading2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 1,
            color: ColourBook.drawerColor,
          ),
          Container(
            height: 120,
            color: ColourBook.drawerColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pushups',style: Stylebook.bodyText1,),
                  Image.asset('assets/Images/PushupsW.png')
                ],
              ),
            ),
          ),
          Container(
            height: 120,
            color: ColourBook.drawerColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pushups',style: Stylebook.bodyText1,),
                  Image.asset('assets/Images/PushupsW.png')
                ],
              ),
            ),
          ),
          Container(
            height: 120,
            color: ColourBook.drawerColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pushups',style: Stylebook.bodyText1,),
                  Image.asset('assets/Images/PushupsW.png')
                ],
              ),
            ),
          ),
          
        ],
      ),
      
    );
  }
}