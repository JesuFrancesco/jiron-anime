import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/wishlist_controller.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

final _wishlistController = Get.put(WishlistController());

class WishlistButton extends StatelessWidget {
  final AsyncMemoizer wishlistMemoizer;
  final Product producto;

  bool get estaEnLaWishlist => _wishlistController.wishlistItems
      .map((e) => e.productId)
      .contains(producto.id);

  const WishlistButton({
    super.key,
    required this.producto,
    required this.wishlistMemoizer,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> obtenerWishlist() async =>
        await wishlistMemoizer.runOnce(() async {
          await _wishlistController.obtenerMiWishlist();
        });

    Future<void> handleAgregarAWishlist(Product producto) async {
      await _wishlistController.agregarProductoAWishlist(producto);
    }

    Future<void> handleQuitarDeWishlist(Product producto) async {
      await _wishlistController.removerItemDeWishlist(producto.id!);
    }

    Widget getAddToWishlistButton() {
      if (!AuthService.isLoggedIn) {
        return GestureDetector(
          onTap: () => Get.toNamed("/sign-in"),
          child: Row(
            children: [
              const Icon(Icons.favorite_border_outlined),
              15.ph,
              const Text("Añadir a lista de deseados"),
            ],
          ),
        );
      }

      return Obx(
        () => GestureDetector(
          onTap:
              estaEnLaWishlist
                  ? () => handleQuitarDeWishlist(producto)
                  : () => handleAgregarAWishlist(producto),
          child: Row(
            children: [
              estaEnLaWishlist
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined),
              15.ph,
              estaEnLaWishlist
                  ? const Text("Quitar de lista de deseados")
                  : const Text("Añadir a lista de deseados"),
            ],
          ),
        ),
      );
    }

    return Obx(() {
      if (_wishlistController.isLoading.value) {
        return const SmallCircularIndicator();
      } else {
        return FutureBuilder(
          future: AuthService.isLoggedIn ? obtenerWishlist() : null,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SmallCircularIndicator();
            } else {
              return getAddToWishlistButton();
            }
          },
        );
      }
    });
  }
}
