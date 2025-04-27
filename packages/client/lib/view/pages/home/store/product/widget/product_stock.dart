import 'package:flutter/material.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
//import 'package:jiron_anime/utils/extensions.dart';

class StockProducto extends StatelessWidget {
  final Product producto;
  const StockProducto({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Stock",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              10.pv,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Stock"),
                      SizedBox(height: 8),
                      Text("ECommerce - Delivery"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${producto.stock!}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Si",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
