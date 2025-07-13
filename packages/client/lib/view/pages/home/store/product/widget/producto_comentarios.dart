import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/pregunta_controller.dart';
import 'package:jiron_anime/viewmodel/controllers/rating_controller.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class PreguntasProducto extends StatelessWidget {
  final Product producto;
  final PreguntaController preguntasController;
  final RatingController ratingsController;

  const PreguntasProducto({
    super.key,
    required this.producto,
    required this.preguntasController,
    required this.ratingsController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Preguntas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              10.pv,
              FutureBuilder<void>(
                future: preguntasController.obtenerPreguntasDeProducto(
                  producto.id!,
                ),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SmallCircularIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Expanded(
                      child: Center(
                        child: Text("Error al cargar las preguntas"),
                      ),
                    );
                  }

                  if (preguntasController.preguntas.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          "Sé el primero en preguntar",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }

                  return Obx(
                    () => Column(
                      children:
                          preguntasController.preguntas
                              .map(
                                (pregunta) =>
                                    PreguntaWidget(pregunta: pregunta),
                              )
                              .toList(),
                    ),
                  );
                },
              ),
              const Text(
                "Reseñas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              10.pv,
              FutureBuilder<void>(
                future: ratingsController.obtenerRatingsDeProducto(
                  producto.id!,
                ),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SmallCircularIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Expanded(
                      child: Center(
                        child: Text("Error al cargar las preguntas"),
                      ),
                    );
                  }

                  if (ratingsController.ratings.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          "¡Sé el primero en reseñar!",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }

                  return Obx(
                    () => Column(
                      children:
                          ratingsController.ratings
                              .map((rating) => ReseniaWidget(resenia: rating))
                              .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PreguntaWidget extends StatelessWidget {
  final ProductQuestion pregunta;
  const PreguntaWidget({super.key, required this.pregunta});

  @override
  Widget build(BuildContext context) {
    final username =
        pregunta.client != null
            ? pregunta.client!.username ?? pregunta.client!.profile!.email!
            : "Cuenta eliminada";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(child: Text(username.substring(0, 1).toUpperCase())),
            10.ph,
            Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        10.pv,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  pregunta.subject!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            10.pv,
            Text(
              pregunta.text!,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        20.pv,
      ],
    );
  }
}

class ReseniaWidget extends StatelessWidget {
  final ProductRating resenia;
  const ReseniaWidget({super.key, required this.resenia});

  @override
  Widget build(BuildContext context) {
    final username =
        resenia.client != null
            ? resenia.client!.username ?? resenia.client!.profile!.email!
            : "Cuenta eliminada";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(child: Text(username.substring(0, 1).toUpperCase())),
              10.ph,
              Expanded(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: List.filled(resenia.score ?? 0, const EstrellaWidget()),
          ),
          10.pv,
          Text(resenia.text ?? "", style: const TextStyle(fontSize: 14)),
          if (resenia.ratingAttachments != null &&
              resenia.ratingAttachments!.isNotEmpty)
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: resenia.ratingAttachments!.length,
              itemBuilder: (context, index) {
                final attachment = resenia.ratingAttachments![index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => Dialog(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: InteractiveViewer(
                                maxScale: 4.0,
                                child: Image.network(
                                  attachment.imageUrl ?? "",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      attachment.imageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          10.pv,
        ],
      ),
    );
  }
}

class EstrellaWidget extends StatelessWidget {
  const EstrellaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.star, color: Colors.yellow);
  }
}
