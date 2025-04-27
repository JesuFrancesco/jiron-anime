import 'package:flutter/material.dart';

class AppColors {
  const AppColors(BuildContext context);

  static const Color backgroundColor = Color(0xFFFFDBCB);

  static const Color primaryColor = Color(0xFFB22525);

  static const Color secondaryColor = Color(0xFFFF8D4E);

  static const Color textColor = Color(0xFF262F34);

  static const List<Color> backgroundLinearGradientColors = [
    Color(0xFFFFDBAB),
    Color.fromARGB(255, 255, 255, 255),
    Color(0xFFFFDBAB),
  ];

  static const List<Color> darkBackgroundLinearGradientColors = [
    Color(0x00000000),
    Color.fromARGB(78, 128, 37, 37),
    Color(0x00000000),
  ];
}
