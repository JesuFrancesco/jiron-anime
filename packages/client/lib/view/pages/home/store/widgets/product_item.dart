import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/pages/home/store/product/producto_page.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class ProductItem extends StatelessWidget {
  final Product producto;

  const ProductItem({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: GestureDetector(
            onTap: () => Get.to(() => ProductoPage(producto: producto)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  (producto.productAttachments != null &&
                          producto.productAttachments!.isNotEmpty)
                      ? Image.network(
                        producto.productAttachments![0].imageUrl!,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white..withValues(alpha: 0.3),
                            child: const Center(
                              child: Icon(
                                Icons.help_outline,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          );
                        },
                      )
                      : Container(
                        color: Colors.white..withValues(alpha: 0.3),
                        child: const Center(
                          child: Icon(
                            Icons.help_outline,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
            ),
          ),
        ),
        5.pv,
        Text(
          producto.name!.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          producto.market!.name!,
          style: const TextStyle(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          producto.formato ?? "NA",
          style: const TextStyle(fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        10.pv,
        ElevatedButton(
          onPressed: () => Get.to(() => ProductoPage(producto: producto)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
          ),
          child: const Text("MÁS INFO"),
        ),
      ],
    );
  }
}
