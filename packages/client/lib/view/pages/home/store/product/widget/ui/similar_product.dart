import 'package:flutter/material.dart';
import 'package:jiron_anime/viewmodel/controllers/productos_controller.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/view/pages/home/store/product/producto_page.dart';
import 'package:jiron_anime/view/components/error_placeholder.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class ProductosSimilaresWidget extends StatelessWidget {
  const ProductosSimilaresWidget({super.key, required this.productoController});

  final ProductoController productoController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.from(
            productoController.similarProductos
                .expand(
                  (producto) => [
                    ProductoSimilarItem(producto: producto),
                    10.ph,
                  ],
                )
                .take(15),
          ),
        ),
      ),
    );
  }
}

class ProductoSimilarItem extends StatelessWidget {
  final Product producto;

  const ProductoSimilarItem({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductoPage(producto: producto),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 120,
            child:
                (producto.productAttachments != null &&
                        producto.productAttachments!.isNotEmpty)
                    ? Column(
                      children: [
                        Image.network(
                          producto.productAttachments![0].imageUrl!,
                          fit: BoxFit.contain,
                          height: 160,
                          width: 90,
                        ),
                        2.pv,
                        Text(
                          producto.name!,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                    : const ImageErrorPlaceholder(),
          ),
        ],
      ),
    );
  }
}
