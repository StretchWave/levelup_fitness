import 'package:flutter/material.dart';
import 'package:levelup_fitness/Screens/Agility.dart';
import 'package:levelup_fitness/Screens/Endurance.dart';
import 'package:levelup_fitness/Screens/Strength.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page', style: Stylebook.heading1),
        backgroundColor: ColourBook.appBarColor,
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        backgroundColor: ColourBook.drawerBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ColourBook.drawerColor),
              child: Text('Menu', style: Stylebook.bodyText1),
            ),
            ListTile(
              hoverColor: ColourBook.drawerHoverColor,
              title: Text('Profile', style: Stylebook.bodyText1),
              onTap: () {
                // Handle profile tap
              },
            ),
            ListTile(
              hoverColor: ColourBook.drawerHoverColor,
              title: Text('Settings', style: Stylebook.bodyText1),
              onTap: () {
                // Handle settings tap
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    // Strength Container
    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StrengthScreen()));
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: ColourBook.statBoxColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '   Strength',
              style: Stylebook.bodyText1,
            ),
            Image.asset(
              'assets/Images/Strength.png',
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    ),

    SizedBox(height: 15),

    // Agility Container
    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AgilityScreen()));
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: ColourBook.statBoxColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '   Agility',
              style: Stylebook.bodyText1,
            ),
            Image.asset(
              'assets/Images/Agility.png',
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    ),

    SizedBox(height: 15),

    // Endurance Container
    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EnduranceScreen()));
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: ColourBook.statBoxColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '   Endurance',
              style: Stylebook.bodyText1,
            ),
            Image.asset(
              'assets/Images/Endurance.png',
              height: 120,
              width: 120,
            ),
          ],
        ),
      ),
    ),
  ],
)

      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 50,
            ),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0, // Set the initial index
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
      backgroundColor: ColourBook.backgroundColor,
    );
  }
}
