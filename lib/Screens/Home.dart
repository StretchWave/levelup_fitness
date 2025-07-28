import 'package:flutter/material.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class StatBox extends StatelessWidget { // class for each stat tile
  final String label;
  final String imagePath;
  final int value;

  const StatBox({
    super.key,
    required this.label,
    required this.imagePath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: ColourBook.statBoxColor, // Dark green for StatBox
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 50, width: 50),
            Text(label, style: Stylebook.bodyText2),
            Text("$value", style: Stylebook.bodyText3),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int strength = 10;
  final int agility = 20;
  final int endurance = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourBook.backgroundColor, // Light green background
      appBar: AppBar(
        leading: Image.asset('assets/Images/DrawerIcoBlack.png', height: 5),
        title: const Text('Home', style: Stylebook.heading1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Colomn start
            Text("STATS", style: Stylebook.bodyText1),
            Row(
              children: [
                StatBox(
                  label: "Strength",
                  imagePath: 'assets/Images/Strength.png',
                  value: strength,
                ),
                StatBox(
                  label: "Agility",
                  imagePath: 'assets/Images/Agility.png',
                  value: agility,
                ),
                StatBox(
                  label: "Endurance",
                  imagePath: 'assets/Images/Endurance.png',
                  value: endurance,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
