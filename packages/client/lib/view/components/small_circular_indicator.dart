import 'package:flutter/material.dart';

class SmallCircularIndicator extends StatelessWidget {
  const SmallCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
