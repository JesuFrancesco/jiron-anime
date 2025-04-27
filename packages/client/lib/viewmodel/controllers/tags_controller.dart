import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/tags_service.dart';

class TagController extends GetxController {
  final service = TagService();

  final isLoading = false.obs;
  final tags = <Tag>[].obs;
  final currentProductTags = <ProductTag>[].obs;

  Future<void> obtenerTags() async {
    tags.value = await service.fetchAll();
  }

  Future<void> obtenerTagsDeProducto(int productId) async {
    currentProductTags.value = await service.fetchFromProduct(productId);
  }
}
