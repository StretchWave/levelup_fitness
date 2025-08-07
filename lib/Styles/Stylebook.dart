import 'package:flutter/material.dart';

class Stylebook {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,  
    fontFamily: 'Montserrat',
    color: Color.fromARGB(255, 86, 158, 96),
    letterSpacing: 4
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 30,  
    fontFamily: 'Montserrat',
    color: Color.fromARGB(255, 240, 240, 240),
    letterSpacing: 4,
    fontWeight: FontWeight.bold
  );
  static const TextStyle heading3 = TextStyle(
    fontSize: 24,  
    fontFamily: 'Montserrat',
    color: Color.fromARGB(255, 240, 240, 240),
    letterSpacing: 4,
  );
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
    letterSpacing: 3,
    color: Color.fromARGB(255, 255, 255, 255),
  );
  static const TextStyle bodyText2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Montserrat',
    color: Color.fromARGB(255, 86, 158, 96),
  );
  static const TextStyle bodyText3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat',
    color: Color.fromARGB(255, 86, 158, 96),
  );

}
class ColourBook{
  static const Color backgroundColor = Color(0xFF74C289); // Light green background
  static const Color appBarColor = Color.fromARGB(255, 255, 255, 255); // Dark green for AppBar
  static const Color statBoxColor = Color.fromARGB(255, 16, 60, 7); // Dark green for StatBox
  static const Color drawerColor = Color.fromARGB(182, 58, 116, 54); // White for Drawer
  static const Color drawerBackgroundColor=Color.fromARGB(172, 65, 144, 59);
  static const Color drawerHoverColor = Color.fromARGB(206, 114, 167, 110); // White for Drawer text
}


