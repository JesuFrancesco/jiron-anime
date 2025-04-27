import 'package:flutter/material.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';

class MockPasarelaDePago extends StatelessWidget {
  const MockPasarelaDePago({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: Column(
          children: [
            const CustomAppbar(title: "Pasarela de pago", showAvatar: true),
            Expanded(
              child: Center(
                child: Text(
                  'Aquí iría la integración con una pasarela de pagos.',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
