import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiron_anime/model/entity/order.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class HistoryOrderItem extends StatelessWidget {
  final Order order;

  const HistoryOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Pedido: ${order.id}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        4.pv,
        Center(
          child: Text(
            "Realizado el: ${order.createdAt != null ? DateFormat("dd/MM/yyyy").format(order.createdAt!) : "Desconocido"}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        16.pv,
        ...order.orderItems!.map((orderItem) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Artículo: ${orderItem.product!.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Cantidad: ${orderItem.amount}"),
                      Text(
                        "Precio: S. ${orderItem.product!.price?.toStringAsFixed(2)}",
                      ),
                      Text("Mercado: ${orderItem.product!.market!.name}"),
                    ],
                  ),
                ),
                if (orderItem.product!.productAttachments?.isNotEmpty ?? false)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.network(
                          orderItem.product!.productAttachments![0].imageUrl!,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
        8.pv,
        Text(
          "Total: S. ${order.totalPrice!.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
