import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/market_controller.dart';
import 'package:jiron_anime/model/entity/market.dart';
import 'package:jiron_anime/view/pages/mis_tiendas/widgets/crear_tienda_button.dart';
import 'package:jiron_anime/view/pages/mis_tiendas/widgets/mercado_card.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class MisTiendasPage extends StatelessWidget {
  const MisTiendasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketController marketController = Get.put(MarketController());

    return Scaffold(
      floatingActionButton: const CrearTiendaButton(),
      body: CustomLayout(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: marketController.obtenerMisMercados,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppbar(title: "Mis tiendas"),
                15.pv,
                Expanded(
                  child:
                      marketController.isLoading.value
                          ? getLoadingMercadosIndicator(context)
                          : ListaMercadosWidget(
                            marketController: marketController,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoadingMercadosIndicator(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          8.pv,
          Text(
            "Cargando mercados...",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ListaMercadosWidget extends StatelessWidget {
  const ListaMercadosWidget({super.key, required this.marketController});

  final MarketController marketController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (marketController.markets.isEmpty) {
        return Center(
          child: Text(
            "No tienes mercados",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      }

      return ListView.builder(
        itemCount: marketController.markets.length,
        itemBuilder: (context, index) {
          final Market market = marketController.markets[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: MercadoCardWidget(
              market: market,
              marketController: marketController,
            ),
          );
        },
      );
    });
  }
}
