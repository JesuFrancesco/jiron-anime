import 'package:flutter/material.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/view/components/error_placeholder.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final Product producto;
  const ImageSlider({super.key, required this.producto});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.producto.productAttachments?.length ?? 0,
              itemBuilder: (context, index) {
                final imageUrl =
                    widget.producto.productAttachments![index].imageUrl;

                return Image.network(
                  imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const ImageErrorPlaceholder();
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _pageController, // PageController
            count: widget.producto.productAttachments?.length ?? 0,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColors.primaryColor,
              dotColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
