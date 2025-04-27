import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/wishlist_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

final _wishlistController = Get.put(WishlistController());

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const CartItemWidget({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final wishlistItemIsLoading = false.obs;

    Future<void> guardarItemEnWishlist() async {
      try {
        wishlistItemIsLoading.value = true;
        await _wishlistController.agregarProductoAWishlist(item.product!);
      } catch (e) {
        // HANDLE ERRORS
      } finally {
        wishlistItemIsLoading.value = false;
      }
    }

    Future<void> quitarItemDeWishlist() async {
      try {
        wishlistItemIsLoading.value = true;
        await _wishlistController.removerItemDeWishlist(item.productId!);
      } catch (e) {
        // HANDLE ERRORS
      } finally {
        wishlistItemIsLoading.value = false;
      }
    }

    bool estaEnLaWishlist() => _wishlistController.wishlistItems
        .map((e) => e.productId)
        .contains(item.productId);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.product!.productAttachments!.first.imageUrl!,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${item.product!.formato} - Cantidad: ${item.amount}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'S/. ${item.product!.price!}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      8.ph,
                      Obx(() {
                        if (wishlistItemIsLoading.value) {
                          return const SmallCircularIndicator();
                        } else {
                          return FutureBuilder(
                            future: _wishlistController.obtenerMiWishlist(),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SmallCircularIndicator();
                              } else {
                                return SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: Obx(
                                    () => TextButton.icon(
                                      onPressed:
                                          estaEnLaWishlist()
                                              ? quitarItemDeWishlist
                                              : guardarItemEnWishlist,
                                      icon: Icon(
                                        estaEnLaWishlist()
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                      label: Text(
                                        estaEnLaWishlist()
                                            ? 'Quitar'
                                            : 'Guardar',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      }),
                      const Spacer(),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder:
                            (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Eliminar'),
                                  ],
                                ),
                              ),
                            ],
                        onSelected: (value) {
                          if (value == 'delete') {
                            onRemove(); // Llama a la función para eliminar el artículo
                          }
                        },
                      ),
                    ],
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
