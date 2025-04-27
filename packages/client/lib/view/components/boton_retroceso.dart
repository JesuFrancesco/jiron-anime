import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/pages/home/store/tienda_page.dart';

class BotonRetroceso extends StatelessWidget {
  final Widget pagina;

  const BotonRetroceso({super.key, this.pagina = const TiendaPage()});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }
}
