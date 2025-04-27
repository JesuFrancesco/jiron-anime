import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/shopping_cart_controller.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/view/theme/colors.dart';

final _shoppingCartController = Get.put(ShoppingCartController());

class AddToCartWidget extends StatelessWidget {
  final AsyncMemoizer cartMemoizer;
  final Product producto;
  const AddToCartWidget({
    super.key,
    required this.producto,
    required this.cartMemoizer,
  });

  bool get estaEnElCarrito => _shoppingCartController.cartItems
      .map((e) => e.productId)
      .contains(producto.id);

  @override
  Widget build(BuildContext context) {
    final numeroItems = 1.obs;
    void increaseCount() =>
        numeroItems.value += numeroItems.value < producto.stock! ? 1 : 0;

    void decreaseCount() => numeroItems.value -= numeroItems.value > 1 ? 1 : 0;

    Future<void> obtenerCarrito() async => await cartMemoizer.runOnce(() async {
      await _shoppingCartController.obtenerMiCarrito();
    });

    Future<void> handleAgregarAlCarrito() async {
      if (producto.id != null) {
        await _shoppingCartController.agregarProductoAlCarrito(
          producto,
          numeroItems.value,
        );

        Get.toNamed("/cart");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: El producto no tiene ID")),
        );
      }
    }

    Widget getAddToCartButton() {
      if (!AuthService.isLoggedIn) {
        return ElevatedButton(
          onPressed: () => handleAgregarAlCarrito(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            "Agregar\nal carrito",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      }

      if (producto.market!.profile!.client!.id == AuthService.getClientId()) {
        return ElevatedButton(
          onPressed: () => Get.toNamed("/my-markets"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            "Ver en mi tienda",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      }

      if (producto.stock! <= 0) {
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
          child: const Text(
            "Fuera de stock",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      }

      return Obx(
        () =>
            estaEnElCarrito
                ? ElevatedButton(
                  onPressed: () => Get.toNamed("/cart"),
                  child: const Text("Ver en el carrito"),
                )
                : ElevatedButton(
                  onPressed: () => handleAgregarAlCarrito(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Agregar\nal carrito",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () =>
              (_shoppingCartController.isLoading.value)
                  ? const SmallCircularIndicator()
                  : FutureBuilder(
                    future: AuthService.isLoggedIn ? obtenerCarrito() : null,
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SmallCircularIndicator();
                      } else {
                        return getAddToCartButton();
                      }
                    },
                  ),
        ),
        IconButton(icon: const Icon(Icons.remove), onPressed: decreaseCount),
        Obx(() => Text('$numeroItems', style: const TextStyle(fontSize: 20))),
        IconButton(icon: const Icon(Icons.add), onPressed: increaseCount),
      ],
    );
  }
}
