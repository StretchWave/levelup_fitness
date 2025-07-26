import 'package:flutter/material.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int strength = 10;
  final int agility = 20;
  final int endurance = 30; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF74C289), // Light green background
      appBar: AppBar(title: const Text('Home', style: Stylebook.heading1)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Colomn start
            Text("Stats", style: Stylebook.bodyText1),
            Row(
              //Row start
              children: [
                Expanded(
                  //Strength Box
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 182, 255, 167), // Move color here
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Images/Strength.png',height: 50,width: 50), // Strength icon
                        Text("Strength", style: Stylebook.bodyText2),
                        Text("$strength", style: Stylebook.bodyText3),
                      ],
                    ),
                  ),
                ),
                Expanded(                           //Agility Box
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Move color here
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Strength", style: Stylebook.bodyText2),
                        Text("$agility", style: Stylebook.bodyText3),
                      ],
                    ),
                  ),
                ),
                Expanded(                           //Endurance Box
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Move color here
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Strength", style: Stylebook.bodyText2),
                        Text("$endurance", style: Stylebook.bodyText3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
