import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/order_controller.dart';
import 'package:jiron_anime/view/pages/history_orders/widgets/history_order_item.dart';
import 'package:jiron_anime/view/pages/payment_success/payment_success_page.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';

class HistoryOrdersPage extends StatelessWidget {
  const HistoryOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController();
    return Scaffold(
      body: CustomLayout(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppbar(title: "Historial de pedidos"),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverFillRemaining(
              child: FutureBuilder(
                future: orderController.obtenerOrdenesDeCompra(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (orderController.ordenes.isEmpty) {
                    return Center(
                      child: Text(
                        "No tienes órdenes realizadas",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  }

                  final completedOrders = List.from(
                    orderController.ordenes.where(
                      (order) => order.status!.toLowerCase() == "completado",
                    ),
                  );

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemCount: completedOrders.length,
                    itemBuilder: (context, index) {
                      final order = completedOrders[index];

                      return GestureDetector(
                        onTap: () => Get.to(PaymentSuccessPage(order: order)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 8.0,
                          ),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: HistoryOrderItem(order: order),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
