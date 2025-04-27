import 'package:flutter/material.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class ProductResumeWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const ProductResumeWidget({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product!.name!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${item.product!.formato} - Cantidad: ${item.amount}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'S/. ${item.product!.price!}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    8.pv,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
