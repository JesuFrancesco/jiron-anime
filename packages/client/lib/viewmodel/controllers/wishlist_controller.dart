import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/model/service/wishlist_service.dart';

class WishlistController extends GetxController {
  WishlistService service = WishlistService();
  final isLoading = false.obs;
  final wishlist = Wishlist().obs;
  final wishlistItems = <WishlistItem>[].obs;

  Future<void> obtenerMiWishlist() async {
    try {
      isLoading.value = true;
      wishlist.value = await service.fetchMyWishlist();
      wishlistItems.value = wishlist.value.wishlistItems!;
    } catch (e) {
      // HANDLE ERRORS
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> agregarProductoAWishlist(Product product) async {
    try {
      isLoading.value = true;
      if (!AuthService.isLoggedIn) {
        Get.toNamed("/sign-in");
        return;
      }

      await service.addItemToMyWishlist(product.id!);
      wishlistItems.add(WishlistItem(product: product, productId: product.id!));
    } catch (e) {
      // HANDLE ERRORS
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removerItemDeWishlist(int productId) async {
    try {
      isLoading.value = true;

      if (!AuthService.isLoggedIn) {
        Get.toNamed("/sign-in");
        return;
      }

      await service.removeItemFromWishlist(productId);
      wishlistItems.removeWhere((element) => element.productId! == productId);
    } catch (e) {
      // HANDLE ERRORS
    } finally {
      isLoading.value = false;
    }
  }
}
