import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/market_controller.dart';
import 'package:jiron_anime/model/entity/market.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class MercadoProductWidget extends StatelessWidget {
  final Market market;
  final Product product;

  final MarketController marketController;
  const MercadoProductWidget({
    super.key,
    required this.market,
    required this.product,
    required this.marketController,
  });

  @override
  Widget build(BuildContext context) {
    final infoProduct = [
      "Precio: \$${product.price ?? 'No disponible'}",
      "Stock: ${product.stock != null ? '${product.stock!} unidades' : 'No disponible'}",
    ].join("\n");

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(product.name ?? "Producto sin nombre"),
        subtitle: Text(infoProduct),
        onTap: () => showUpdateProductSheet(context, product),
        onLongPress: () => showDeleteProductSheet(context, product),
      ),
    );
  }

  void showUpdateProductSheet(BuildContext context, Product? product) {
    final isLoading = false.obs;
    final TextEditingController priceController = TextEditingController(
      text: product?.price?.toString() ?? '',
    );
    final TextEditingController stockController = TextEditingController(
      text: product?.stock?.toString() ?? '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
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
                  "Actualizar Producto",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                16.pv,
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: "Precio",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                16.pv,
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: "Stock",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                16.pv,
                ElevatedButton(
                  onPressed: () async {
                    isLoading.value = true;

                    final updatedPrice = double.tryParse(priceController.text);
                    final updatedStock = int.tryParse(stockController.text);

                    final updatedProduct = product!.copyWith(
                      price: updatedPrice,
                      stock: updatedStock,
                    );

                    if (updatedPrice != null && updatedStock != null) {
                      await marketController.actualizarProducto(
                        updatedProduct,
                        market.id!,
                      );

                      isLoading.value = false;

                      ScaffoldMessenger.of(
                        context.mounted ? context : context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text('Se ha actualizado tu producto'),
                        ),
                      );

                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, ingrese valores válidos.'),
                        ),
                      );
                    }
                  },
                  child:
                      isLoading.value
                          ? const SmallCircularIndicator()
                          : const Text("Guardar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteProductSheet(BuildContext context, Product? product) {
    final isLoading = false.obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
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
                  "Eliminar Producto",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                16.pv,
                Text(
                  "¿Estás seguro de que deseas eliminar este producto?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                16.pv,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        try {
                          isLoading.value = true;

                          await marketController.eliminarProducto(
                            product!.id!,
                            market.id!,
                          );
                          ScaffoldMessenger.of(
                            context.mounted ? context : context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text('El producto ha sido eliminado.'),
                            ),
                          );
                        } catch (e) {
                          // HANDLE ERROR
                        } finally {
                          isLoading.value = false;

                          Get.back();
                        }
                      },
                      child:
                          isLoading.value
                              ? const SmallCircularIndicator()
                              : const Text("Eliminar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
