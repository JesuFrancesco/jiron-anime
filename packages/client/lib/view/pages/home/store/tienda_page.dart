import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/config/const.dart';
import 'package:jiron_anime/model/entity/tag.dart';
import 'package:jiron_anime/view/pages/home/store/widgets/tienda_footer.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/productos_controller.dart';
import 'package:jiron_anime/view/pages/home/store/widgets/product_buttonbar.dart';
import 'package:jiron_anime/view/pages/home/store/widgets/product_item.dart';
import 'package:jiron_anime/view/pages/home/store/widgets/product_carousel.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class TiendaPage extends StatefulWidget {
  const TiendaPage({super.key});

  @override
  State<TiendaPage> createState() => _TiendaPageState();
}

class _TiendaPageState extends State<TiendaPage> {
  final productoController = Get.put(ProductoController());
  final currentTags = <Tag>[].obs;
  final page = 1.obs;

  Future<void> fetchData() async {
    if (currentTags.isEmpty) {
      await productoController.obtenerProductosRecientes(page.value);
    } else {
      await productoController.filtrarProductosPorGenero(
        currentTags,
        page.value,
      );
    }
  }

  void cambiarPaginaAdelante() {
    page.value = page.value + 1;
    fetchData();
  }

  void cambiarPaginaAtras() {
    page.value = page.value - 1;
    fetchData();
  }

  Future<void> _changeTagsCallback(List<Tag> tags) async {
    currentTags.value = tags;

    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: Obx(
          () =>
              productoController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                    onRefresh: fetchData,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jiron Anime",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  AuthController.getAvatarIcon(),
                                ],
                              ),
                              15.pv,
                              TagsBarButton(onTagPressed: _changeTagsCallback),
                              15.pv,
                              const ProductCarousel(),
                              10.pv,
                              buildProductoGrid(currentTags),
                              5.pv,
                              getPaginationRow(),
                              30.pv,
                              const TiendaFooterWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }

  Widget getPaginationRow() {
    return productoController.productos.isEmpty
        ? 0.pv
        : Column(
          children: [
            Text(
              "Novedades de la semana",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            5.pv,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: page.value > 1 ? cambiarPaginaAtras : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        page.value > 1
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                  ),
                  child: const Text("<"),
                ),
                10.ph,
                Text("Página ${page.value}"),
                10.ph,
                ElevatedButton(
                  onPressed:
                      productoController.productos.length >
                              ConstValues.RESULTS_PER_PAGE
                          ? cambiarPaginaAdelante
                          : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        productoController.productos.length >
                                ConstValues.RESULTS_PER_PAGE
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                  ),
                  child: const Text(">"),
                ),
              ],
            ),
          ],
        );
  }

  Widget buildProductoGrid(List<Tag> tags) {
    if (productoController.productos.isEmpty) {
      return Text(
        "No hay mangas disponibles",
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.45,
        crossAxisSpacing: 10,
      ),
      itemCount: productoController.productos.length - 2,
      itemBuilder: (context, index) {
        final producto = productoController.productos[index];
        return ProductItem(producto: producto);
      },
    );
  }
}
