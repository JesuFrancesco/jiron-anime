import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/wishlist_controller.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'wishlist_item.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Scaffold(
      body: CustomLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const CustomAppbar(title: "Lista de deseados"),
                  FutureBuilder(
                    future: controller.obtenerMiWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Algo salió mal: ${snapshot.error}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      } else {
                        if (controller.wishlistItems.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                "No tienes items en tu lista de deseados",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                        }

                        return Obx(
                          () => Column(
                            children: [
                              ...controller.wishlistItems.map(
                                (item) => WishlistItemWidget(
                                  item: item,
                                  controller: controller,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Articulos en lista: ${controller.wishlistItems.length}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
