import 'package:flutter/material.dart';
import 'package:levelup_fitness/Screens/Workout.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';

class StatBox extends StatelessWidget {
  // class for each stat tile
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

class HomeScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<HomeScreen> {
  int strength = 10;
  int agility = 20;
  int endurance = 30;
  int streak = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourBook.backgroundColor, // Light green background
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
            iconSize: 37,
          ),
        ),
        backgroundColor: ColourBook.appBarColor,
        title: const Text('Home', style: Stylebook.heading1),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            //Colomn start
            Text("STATS", style: Stylebook.bodyText1),
            Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0)),
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
            Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0)),
            Text("STREAK", style: Stylebook.bodyText1),
            Padding(padding: const EdgeInsets.fromLTRB(0, 12, 0, 0)),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // Streak box
                    height: 150,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: ColourBook.statBoxColor, // Dark green for StatBox
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(StreakFire(streak).streak(), height: 100),
                        Text("Current Streak", style: Stylebook.bodyText2),
                        Text("$streak", style: Stylebook.bodyText3),
                      ],
                    ),

                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0)),
            Text("", style: Stylebook.bodyText1),
            Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/HomeIconW.png',
              width: 35,
              height: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/SitUpIconB.png',
              width: 29,
              height: 29,
            ),
            label: 'Grind',
          ),
        ],
      ),
    );
  }
}

class StreakFire {
  //Streak
  int currentSreak;

  StreakFire(this.currentSreak);
  String streak() {
    if (currentSreak == 0) {
      return 'assets/Images/Thumbsup.png';
    } else if (currentSreak < 5 && currentSreak > 0) {
      return 'assets/Images/Fire1.png';
    } else if (currentSreak >= 5 && currentSreak < 10) {
      return 'assets/Images/Fire2.png';
    } else if (currentSreak >= 10 && currentSreak < 20) {
      return 'assets/Images/Fire3.png';
    } else {
      return 'assets/Images/Fire4.png';
    }
  }
}
