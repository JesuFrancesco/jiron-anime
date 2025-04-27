import 'package:get/get.dart';
import 'package:jiron_anime/model/service/notification_service.dart';

import '../../model/entity/notification.dart';

class NotificationsController extends GetxController {
  final isLoading = false.obs;
  final service = NotificationsService();
  final notificaciones = <Notification>[].obs;

  Future<void> obtenerNotificaciones() async {
    try {
      isLoading.value = true;
      notificaciones.value = await service.fetchAll();
    } catch (e) {
      // HANDLE ERRORS
    } finally {
      isLoading.value = false;
    }
  }
}
