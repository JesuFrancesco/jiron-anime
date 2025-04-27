import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/assistant_controller.dart';
import 'package:jiron_anime/model/entity/local_message.dart';
import 'package:jiron_anime/view/pages/chat/widget/message_widget.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/small_circular_indicator.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assistantController = Get.put(AssistantController());
    final messageControllerInput = TextEditingController();

    return Scaffold(
      body: CustomLayout(
        child: Column(
          children: [
            const CustomAppbar(title: "Soporte"),
            Text("Soporte", style: Theme.of(context).textTheme.titleSmall),
            // CHAT MESSAGES
            FutureBuilder<void>(
              future: assistantController.cargarHistorial(),
              builder:
                  (context, snapshot) => Obx(
                    () => Expanded(
                      child:
                          assistantController.isLoading.value
                              ? const Center(child: SmallCircularIndicator())
                              : assistantController.messages.isEmpty
                              ? const Center(
                                child: Text("Consulta lo que necesites"),
                              )
                              : ListView.builder(
                                itemCount: assistantController.messages.length,
                                itemBuilder: (context, index) {
                                  final message =
                                      assistantController.messages[index];
                                  return MessageWidget(message: message);
                                },
                              ),
                    ),
                  ),
            ),
            // CHAT INPUT
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageControllerInput,
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
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (messageControllerInput.text.isNotEmpty) {
                            assistantController.enviarMensaje(
                              LocalMessage(
                                sender: AuthController.fullName,
                                message: messageControllerInput.text,
                                createdAt: DateTime.now(),
                              ),
                            );

                            messageControllerInput.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
