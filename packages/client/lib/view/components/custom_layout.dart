import 'package:flutter/material.dart';
import 'package:jiron_anime/view/theme/colors.dart';

class CustomLayout extends StatelessWidget {
  final double px, pt, pb;
  const CustomLayout({
    super.key,
    required this.child,
    this.px = 20,
    this.pt = kToolbarHeight,
    this.pb = 0,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      decoration:
          !isDarkMode
              ? const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.5, 1],
                  colors: AppColors.backgroundLinearGradientColors,
                ),
              )
              : const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.5, 1],
                  colors: AppColors.darkBackgroundLinearGradientColors,
                ),
              ),
      child: Padding(
        padding: EdgeInsets.only(left: px, right: px, top: pt),
        child: child,
      ),
    );
  }
}
