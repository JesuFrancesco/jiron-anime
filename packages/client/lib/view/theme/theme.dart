// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/view/theme/fonts.dart';

const _sharedTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 32,
  ),
  titleMedium: TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  ),
  labelMedium: TextStyle(fontFamily: AppFonts.primaryFont, fontSize: 18),
  headlineLarge: TextStyle(fontFamily: AppFonts.primaryFont),
  headlineSmall: TextStyle(fontFamily: AppFonts.primaryFont),
);

final appTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.primaryColor,
  ),
  textTheme: _sharedTextTheme,
).copyWith(iconTheme: const IconThemeData(color: AppColors.primaryColor));

// final appTheme = ThemeData(
//   progressIndicatorTheme: const ProgressIndicatorThemeData(
//     color: AppColors.primaryColor,
//   ),
//   elevatedButtonTheme: const ElevatedButtonThemeData(
//       style: ButtonStyle(
//           backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
//           foregroundColor: WidgetStatePropertyAll(Colors.white))),
//   scaffoldBackgroundColor: AppColors.backgroundColor,
//   primaryColor: AppColors.primaryColor,
//   brightness: Brightness.light,
//   // switchTheme: const SwitchThemeData(
//   //   trackColor: WidgetStatePropertyAll(AppColors.primaryColor),
//   //   thumbColor: WidgetStatePropertyAll(Colors.white),
//   // ),
//   switchTheme:
//       SwitchThemeData(trackColor: WidgetStateProperty.resolveWith((states) {
//     if (states.contains(WidgetState.selected)) return Colors.grey;
//     return Colors.green;
//   })),
//   sliderTheme: SliderThemeData(
//       activeTrackColor: AppColors.primaryColor,
//       thumbColor: Colors.white,
//       inactiveTrackColor: Colors.grey.shade700
//       // activeColor: Colors.white,
//       // inactiveThumbColor: Colors.white,
//       // inactiveTrackColor: Colors.grey.shade700,
//       ),
//   iconTheme: const IconThemeData(color: AppColors.primaryColor),
//   indicatorColor: AppColors.primaryColor,
//   textTheme: _sharedTextTheme,
// );

final darkAppTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.primaryColor,
  ),
  textTheme: _sharedTextTheme,
).copyWith(
  // COMPLETAR
  iconTheme: const IconThemeData(color: AppColors.primaryColor),
);
