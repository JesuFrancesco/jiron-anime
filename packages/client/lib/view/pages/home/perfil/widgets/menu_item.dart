import 'package:flutter/material.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class IconMenuItem extends StatelessWidget {
  final VoidCallback? fnOnTap;
  final IconData icon;
  final String text;

  const IconMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.fnOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fnOnTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 24),
            16.ph,
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const Icon(Icons.chevron_right, size: 24),
          ],
        ),
      ),
    );
  }
}
