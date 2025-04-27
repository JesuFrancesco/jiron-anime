import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/pregunta_service.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';

class PreguntaController extends GetxController {
  final service = PreguntaService();

  final preguntas = <ProductQuestion>[].obs;

  Future<void> obtenerPreguntasDeProducto(int productId) async {
    preguntas.value = await service.fetchProductQuestions(productId);
  }

  Future<void> crearPreguntaDeProducto(ProductQuestion productoPregunta) async {
    await service.submitProductQuestion(productoPregunta);
    final successfulQuestion = productoPregunta.copyWith(
      client: Client(username: AuthController.fullName),
    );
    preguntas.add(successfulQuestion);
  }
}
