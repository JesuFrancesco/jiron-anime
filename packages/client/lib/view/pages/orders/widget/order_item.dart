import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiron_anime/model/entity/order.dart';
import 'package:jiron_anime/model/entity/order_item.dart';
import 'package:jiron_anime/view/pages/chat/chat_page.dart';
import 'package:jiron_anime/view/pages/home/store/product/producto_page.dart';
import 'package:jiron_anime/view/pages/orders/widget/confirm_order_button.dart';
import 'package:jiron_anime/view/pages/payment_success/payment_success_page.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:jiron_anime/viewmodel/controllers/order_controller.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderController orderController;
  final Order orden;

  const OrderItemWidget({
    super.key,
    required this.orden,
    required this.orderController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.to(() => PaymentSuccessPage(order: orden)),
                    child: Text(
                      "Orden n° ${orden.id}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
            ...orden.orderItems!.map(
              (orderItem) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pedido realizado el: ${DateFormat("dd/MM/yyyy").format(orden.createdAt!)}",
                              ),
                              8.pv,
                              Text("Pedido: ${orden.id}"),
                              8.pv,
                              Text(
                                "Articulo: ${orderItem.amount!} x ${orderItem.product!.name}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              8.pv,
                              Text(
                                "Total: S. ${orderItem.product!.price?.toStringAsFixed(2)}",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: GestureDetector(
                          onTap:
                              () => Get.to(
                                () =>
                                    ProductoPage(producto: orderItem.product!),
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 160,
                                width: 90,
                                child:
                                    orderItem.product!.productAttachments !=
                                            null
                                        ? Image.network(
                                          orderItem
                                              .product!
                                              .productAttachments![0]
                                              .imageUrl!,
                                          fit: BoxFit.contain,
                                        )
                                        : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.pv,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed:
                              () => Get.to(
                                ChatPage(mercado: orderItem.product!.market!),
                              ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                          ),
                          child: const Text(
                            "CHAT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap:
                              () => showMarketBottomSheet(context, orderItem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    (orderItem.product!.market!.logoUrl != null)
                                        ? NetworkImage(
                                          orderItem.product!.market!.logoUrl!,
                                        )
                                        : null,
                                child:
                                    (orderItem.product!.market!.logoUrl == null)
                                        ? const Text("?")
                                        : null,
                              ),
                              8.ph,
                              Flexible(
                                child: Text(
                                  maxLines: 1,
                                  orderItem.product!.market!.name!.trim(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            15.pv,
            ElevatedButton.icon(
              onPressed: () {
                showConfirmBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              icon: const Icon(Icons.check),
              label: const Text(
                "CONFIRMAR",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PersistentBottomSheetController showMarketBottomSheet(
    BuildContext context,
    OrderItem orderItem,
  ) {
    return showBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                (orderItem.product!.market!.logoUrl != null)
                                    ? NetworkImage(
                                      orderItem.product!.market!.logoUrl!,
                                    )
                                    : null,
                            child:
                                (orderItem.product!.market!.logoUrl == null)
                                    ? const Text("?")
                                    : null,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              orderItem.product!.market!.name!,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  void showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "¿Confirmar que esta orden está completa?",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Cancelar"),
                    ),
                    ConfirmarOrdenButton(
                      orderController: orderController,
                      orden: orden,
                    ),
                  ],
                ),
              ],
            ),
          ),
      isDismissible: true,
      isScrollControlled: true,
    );
  }
}
