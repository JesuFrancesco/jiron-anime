import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/productos_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';

class ProductCarousel extends StatefulWidget {
  const ProductCarousel({super.key});

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final productoController = Get.put(ProductoController());

  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Product> productos = productoController.productos.toList();

    void toggleImage() {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % productos.length;
      });
    }

    if (productos.isEmpty) return Container();

    final currentComic = productos[currentImageIndex];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      height: 120,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: SizedBox.expand(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white..withValues(alpha: 0.3),
                  BlendMode.lighten,
                ),
                child:
                    currentComic.productAttachments != null &&
                            currentComic.productAttachments!.isNotEmpty
                        ? Image.network(
                          currentComic.productAttachments![0].imageUrl!,
                          fit: BoxFit.cover,
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
          Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left, color: Colors.black),
                      onPressed: toggleImage,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white..withValues(alpha: 0.5),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              currentComic.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 0),
                            Text(
                              currentComic.descripcion ?? "No hay descripción",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.5,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right, color: Colors.black),
                      onPressed: toggleImage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
