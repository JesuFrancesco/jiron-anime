import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/wishlist_controller.dart';
import 'package:jiron_anime/model/entity/wishlist_item.dart';
import 'package:jiron_anime/view/pages/home/store/product/producto_page.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class WishlistItemWidget extends StatelessWidget {
  final WishlistItem item;
  final WishlistController controller;

  const WishlistItemWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = false.obs;

    Future handleDeleteItem() async {
      try {
        isLoading.value = true;
        await controller.removerItemDeWishlist(item.productId!);

        controller.wishlist.value.wishlistItems!.removeWhere(
          (element) => element.productId == item.productId!,
        );
      } catch (e) {
        // handle errors
      } finally {
        isLoading.value = false;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              item.product!.productAttachments!.first.imageUrl!,
              fit: BoxFit.cover,
              width: 70,
              height: 120,
            ),
          ),
          16.ph,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                4.pv,
                Text(
                  'S/. ${item.product!.price?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
                4.pv,
                Text(
                  item.product!.formato!,
                  style: const TextStyle(fontSize: 12),
                ),
                8.pv,
                ElevatedButton(
                  onPressed:
                      () => Get.to(() => ProductoPage(producto: item.product!)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'VER EN TIENDA',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () =>
                isLoading.value
                    ? const SmallCircularIndicator()
                    : IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: handleDeleteItem,
                    ),
          ),
        ],
      ),
    );
  }
}
