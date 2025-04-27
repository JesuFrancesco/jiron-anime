import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/market_controller.dart';
import 'package:jiron_anime/model/entity/market.dart';
import 'package:jiron_anime/view/pages/create_product/create_product_page.dart';
import 'package:jiron_anime/view/pages/mis_tiendas/widgets/mercado_producto_card.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class MercadoCardWidget extends StatelessWidget {
  const MercadoCardWidget({
    super.key,
    required this.market,
    required this.marketController,
  });

  final Market market;
  final MarketController marketController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.store),
              Text(
                market.name ?? "Nombre no disponible",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'eliminar') {
                    showDeleteConfirmation(context);
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'eliminar',
                        child: Row(
                          children: [Icon(Icons.delete), Text('Eliminar')],
                        ),
                      ),
                    ],
              ),
            ],
          ),
          16.pv,
          Center(
            child: SizedBox(
              height: 256,
              child: Image.network(market.logoUrl!, fit: BoxFit.cover),
            ),
          ),
          8.pv,
          Text("Correo: ${market.contactEmail ?? 'No disponible'}"),
          4.pv,
          Text("Teléfono: ${market.contactPhone ?? 'No disponible'}"),
          16.pv,
          Center(
            child: ElevatedButton(
              onPressed:
                  () => Get.to(() => AgregarProductoScreen(market: market)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
              child: const Text("Agregar producto"),
            ),
          ),
          16.pv,
          if (market.products?.isNotEmpty ?? false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Productos:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                8.pv,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: market.products?.length ?? 0,
                  itemBuilder: (context, productIndex) {
                    final product = market.products?[productIndex];

                    return MercadoProductWidget(
                      market: market,
                      product: product!,
                      marketController: marketController,
                    );
                  },
                ),
              ],
            )
          else
            const Text("No hay productos disponibles para este mercado."),
        ],
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context) {
    final isDeleting = false.obs;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () =>
                  isDeleting.value
                      ? const SmallCircularIndicator()
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "¿Estás seguro de que deseas eliminar este mercado?",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          16.pv,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    isDeleting.value = true;
                                    await marketController.deleteMercado(
                                      market.id!,
                                    );
                                  } catch (e) {
                                    // handle
                                  } finally {
                                    isDeleting.value = false;
                                    Navigator.of(
                                      context.mounted ? context : context,
                                    ).pop();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Sí"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("No"),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
    );
  }
}
