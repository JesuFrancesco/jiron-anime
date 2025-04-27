import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrearTiendaButton extends StatelessWidget {
  const CrearTiendaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Get.toNamed("/create-market"),
      label: const Text("Crear tienda"),
      icon: const Icon(Icons.add),
    );
  }
}
