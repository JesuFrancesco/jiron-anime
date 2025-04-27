import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/local_message.dart';
import 'package:jiron_anime/model/service/assistant_service.dart';

class AssistantController extends GetxController {
  final service = AssistantService();
  final isLoading = false.obs;
  final messages = <LocalMessage>[].obs;

  Future<void> cargarHistorial() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      messages.value = [];
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> enviarMensaje(LocalMessage message) async {
    messages.add(message);
    try {
      final consulta = message.message;

      String respuestaBot = "";

      var repsonse = LocalMessage(
        sender: "AnimeBot",
        message: respuestaBot,
        createdAt: DateTime.now(),
      );

      messages.add(repsonse);
      final messageIndex = messages.length - 1;

      await for (var chunk in service.enviarMensaje(consulta)) {
        respuestaBot += chunk;
        messages[messageIndex] = LocalMessage(
          sender: "AnimeBot",
          message: respuestaBot,
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      print("Algo salió mal");
      print(e);
    }
  }
}
