import 'package:flutter/material.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:url_launcher/url_launcher.dart';

class TiendaFooterWidget extends StatelessWidget {
  const TiendaFooterWidget({super.key});

  Future<void> abrirUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Contáctanos por ...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          15.pv,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => abrirUrl('https://www.facebook.com/'),
                child: const Icon(Icons.facebook, size: 48),
              ),
              20.ph,
              GestureDetector(
                onTap: () => abrirUrl('tel:1234567890'),
                child: const Icon(Icons.phone, size: 48),
              ),
              20.ph,
              GestureDetector(
                onTap: () => abrirUrl('sms:1234567890'),
                child: const Icon(Icons.sms, size: 48),
              ),
            ],
          ),
          15.pv,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Jiron anime - Todos los derechos reservados",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
