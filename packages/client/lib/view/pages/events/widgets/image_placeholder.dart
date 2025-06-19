import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Get.theme.colorScheme;
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: colors.onSurface.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}
