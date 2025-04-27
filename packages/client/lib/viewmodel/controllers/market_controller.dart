import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/market.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:jiron_anime/model/service/market_service.dart';

class MarketController extends GetxController {
  final marketService = MarketService();

  final isLoading = false.obs;
  final markets = <Market>[].obs;

  Future<void> crearNuevoMercado(Market mercado) async {
    try {
      isLoading.value = true;
      final newMarket = await marketService.createNewMarket(mercado);
      markets.add(newMarket);
    } catch (e) {
      Get.snackbar(
        "Error",
        "No se pudo crear tu mercado: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
      throw Error();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMercado(int mercadoId) async {
    try {
      isLoading.value = true;

      await marketService.deleteMarket(mercadoId);
      markets.removeWhere((element) => element.id! == mercadoId);

      Get.snackbar(
        "Información",
        "Se ha eliminado tu mercado",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "No se pudo crear tu mercado: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
      return;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> agregarNuevoProducto(Product data, int marketId) async {
    try {
      isLoading.value = true;
      await marketService.createNewProduct(data, marketId);
    } catch (e) {
      Get.snackbar(
        "Error",
        "No se pudo crear este producto: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
      return;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> eliminarProducto(int productId, int marketId) async {
    try {
      isLoading.value = true;
      await marketService.deleteProductFromMarket(productId, marketId);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Algo salio mal al eliminar el producto: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
      return;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> actualizarProducto(Product data, int marketId) async {
    try {
      isLoading.value = true;
      await marketService.updateExistingProduct(data, marketId);
    } catch (e) {
      // HANDLE ERRORS
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> obtenerMisMercados() async {
    try {
      isLoading.value = true;
      final fetchedMarkets = await marketService.fetchMyMarkets();
      markets.assignAll(fetchedMarkets);
    } catch (e) {
      Get.snackbar(
        "Error",
        "No se pudieron cargar los mercados: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    obtenerMisMercados();
  }
}
