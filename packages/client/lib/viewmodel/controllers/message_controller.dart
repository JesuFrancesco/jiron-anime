import 'dart:io';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/local_message.dart';

class MessageController extends GetxController {
  // final service = MessageService();

  final isLoading = false.obs;
  final messages = <LocalMessage>[].obs;
  final selectedImages = <File>[].obs;

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
    limpiarImagenes();
  }

  Future<void> agregarImagen(File image) async {
    selectedImages.add(image);
  }

  Future<void> quitarImagen(int index) async {
    selectedImages.removeAt(index);
  }

  Future<void> limpiarImagenes() async {
    selectedImages.clear();
  }
}
