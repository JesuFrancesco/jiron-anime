import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/tags_controller.dart';
import 'package:jiron_anime/model/entity/tag.dart';
import 'package:jiron_anime/view/pages/home/search/busqueda_page.dart';
import 'package:jiron_anime/view/theme/colors.dart';

class TagsBarButton extends StatefulWidget {
  final Function onTagPressed;

  const TagsBarButton({super.key, required this.onTagPressed});

  @override
  State<TagsBarButton> createState() => _TagsBarButtonState();
}

class _TagsBarButtonState extends State<TagsBarButton> {
  final memoizer = AsyncMemoizer();
  TagController controller = Get.put(TagController());

  Future<void> cargarTags() async {
    await memoizer.runOnce(() async {
      await controller.obtenerTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            future: cargarTags(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: null,
                          child: Text(
                            "Cargando...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Algo salió mal...'));
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            widget.onTagPressed(<Tag>[]);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                          child: const Text("Catálogo completo"),
                        ),
                        ...controller.tags
                            .map(
                              (tag) => {
                                TextButton(
                                  onPressed: () {
                                    widget.onTagPressed([tag]);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: Text(tag.name!),
                                ),
                                const SizedBox(width: 5),
                              },
                            )
                            .expand((set) => set),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              Get.to(const BusquedaPage());
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.transparent),
              ),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
