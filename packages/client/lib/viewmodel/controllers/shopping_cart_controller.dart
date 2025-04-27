import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/model/service/cart_service.dart';

class ShoppingCartController extends GetxController {
  final service = CartService();

  final isLoading = false.obs;
  final carrito = ShoppingCart().obs;
  final cartItems = <CartItem>[].obs;

  Future<void> obtenerMiCarrito() async {
    try {
      isLoading.value = true;
      carrito.value = await service.fetchCartWithProducts();
      cartItems.value = carrito.value.cartItems!;
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> agregarProductoAlCarrito(Product producto, int amount) async {
    try {
      if (!AuthService.isLoggedIn) {
        Get.toNamed("/sign-in");
        return;
      }

      isLoading.value = true;
      await service.addProductToCart(amount, producto.id!);
      cartItems.add(
        CartItem(
          product: producto,
          productId: producto.id,
          amount: amount,
          addedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> eliminarProductoDelCarrito(int productId) async {
    try {
      if (!AuthService.isLoggedIn) {
        Get.toNamed("/sign-in");
        return;
      }
      isLoading.value = true;
      await service.deleteProductFromCart(productId);

      cartItems.removeWhere((element) => element.productId! == productId);
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }
}
