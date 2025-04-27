import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/order.dart';
import 'package:jiron_anime/model/entity/order_item.dart';
import 'package:jiron_anime/model/service/cart_service.dart';
import 'package:jiron_anime/model/service/order_service.dart';

class OrderController extends GetxController {
  final service = OrderService();
  final isLoading = false.obs;

  final cartService = CartService();

  final ordenes = <Order>[].obs;

  Future<void> obtenerOrdenesDeCompra() async {
    try {
      isLoading.value = true;
      ordenes.value = await service.fetchMyOrderHistory();
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<Order> procesarOrdenDeCompra(List<OrderItem> items) async {
    try {
      isLoading.value = true;
      final orden = await service.processPurchaseOrder(items);
      return orden;
    } catch (e) {
      // handle errors
      throw Error();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Order> completarOrden(int ordenId) async {
    try {
      isLoading.value = true;
      final orden = await service.completeOrder(ordenId);

      return orden;
    } catch (e) {
      // handle errors
      throw Error();
    } finally {
      isLoading.value = false;
    }
  }
}
