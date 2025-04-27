import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/order_controller.dart';
import 'package:jiron_anime/model/entity/order.dart';

class ConfirmarOrdenButton extends StatelessWidget {
  const ConfirmarOrdenButton({
    super.key,
    required this.orderController,
    required this.orden,
  });

  final OrderController orderController;
  final Order orden;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          orderController.isLoading.value
              ? null
              : () async {
                try {
                  orderController.isLoading.value = true;
                  await orderController.completarOrden(orden.id!);

                  final index = orderController.ordenes.indexWhere(
                    (e) => e.id == orden.id,
                  );
                  if (index != -1) {
                    final updatedOrder = orderController.ordenes[index]
                        .copyWith(status: "Completado");
                    orderController.ordenes[index] = updatedOrder;
                  }
                } catch (e) {
                  // HANDLE ERRORS
                } finally {
                  orderController.isLoading.value = false;
                  Get.back();
                }
              },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Obx(
        () =>
            orderController.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Confirmar"),
      ),
    );
  }
}
