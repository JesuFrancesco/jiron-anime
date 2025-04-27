import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/pregunta_controller.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/model/entity/product_question.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class PreguntaButton extends StatelessWidget {
  final Product producto;
  final PreguntaController preguntaController;
  const PreguntaButton({
    super.key,
    required this.producto,
    required this.preguntaController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () =>
              (AuthService.isLoggedIn)
                  ? showPreguntaBottomSheet(context)
                  : Get.toNamed("/sign-in"),
      child: Row(
        children: [
          const Icon(Icons.question_mark),
          15.ph,
          const Text("Preguntar"),
        ],
      ),
    );
  }

  Future<void> showPreguntaBottomSheet(BuildContext context) {
    final submitLoading = false.obs;
    final TextEditingController asuntoControllerInput = TextEditingController();
    final TextEditingController justificacionControllerInput =
        TextEditingController();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 320,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () =>
                      submitLoading.value
                          ? const SmallCircularIndicator()
                          : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Realiza una pregunta',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              20.pv,
                              TextFormField(
                                controller: asuntoControllerInput,
                                decoration: const InputDecoration(
                                  labelText: 'Asunto',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                              20.pv,
                              TextFormField(
                                controller: justificacionControllerInput,
                                minLines: 1,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  labelText: 'Envía tu mensaje',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                ),
                              ),
                              30.pv,
                              ElevatedButton(
                                child: const Text('Enviar'),
                                onPressed: () async {
                                  if (asuntoControllerInput.text.isNotEmpty &&
                                      justificacionControllerInput
                                          .text
                                          .isNotEmpty) {
                                    submitLoading.value = true;

                                    final pregunta = ProductQuestion(
                                      clientId: AuthService.getClientId(),
                                      productId: producto.id,
                                      subject: asuntoControllerInput.text,
                                      text: justificacionControllerInput.text,
                                    );

                                    await preguntaController
                                        .crearPreguntaDeProducto(pregunta);

                                    asuntoControllerInput.clear();
                                    justificacionControllerInput.clear();

                                    submitLoading.value = false;
                                    Get.back();
                                  } else {
                                    Get.dialog(
                                      const InfoDialog(
                                        title: "Alerta",
                                        message:
                                            "Completa los inputs para enviar tu pregunta.",
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
