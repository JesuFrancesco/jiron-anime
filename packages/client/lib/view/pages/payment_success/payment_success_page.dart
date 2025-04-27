import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class PaymentSuccessPage extends StatelessWidget {
  final Order order;
  const PaymentSuccessPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(title: "Orden ${order.id}", showAvatar: true),
            20.pv,
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.orange,
            ),
            20.pv,
            const Text(
              'Pago realizado!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Hemos recibido tu pago.'),
            30.pv,
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Estado', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            10.pv,
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: Colors.orange),
                SizedBox(width: 10),
                Text('Realizado'),
              ],
            ),
            20.pv,
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Fecha', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            10.pv,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now())),
              ],
            ),
            20.pv,
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Método de pago',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            10.pv,
            Row(
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Mastercard-logo.png/480px-Mastercard-logo.png',
                  width: 50,
                ),
                10.ph,
                const Text('Mastercard\nTermina en 4521'),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  DescargarConstanciaButton(order: order),
                  15.pv,
                  if (order.status!.toLowerCase() != "completado") ...[
                    const IrAOrdenesButton(),
                    15.pv,
                  ],
                  const VolverATiendaButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescargarConstanciaButton extends StatelessWidget {
  const DescargarConstanciaButton({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        // onPressed: () => descargarConstancia(order),
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        icon: const Icon(Icons.download, color: Colors.white),
        label: const Text(
          'DESCARGAR CONSTANCIA',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class VolverATiendaButton extends StatelessWidget {
  const VolverATiendaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed("/home"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        label: const Text(
          'VOLVER A TIENDA',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class IrAOrdenesButton extends StatelessWidget {
  const IrAOrdenesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed("/orders"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        label: const Text(
          'VER ORDENES EN CURSO',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
