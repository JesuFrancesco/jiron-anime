import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/model/service/event_service.dart';

class SingleEventController extends GetxController {
  final String eventId;
  final Rx<Event?> event = Rx<Event?>(null);
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  SingleEventController(this.eventId);

  @override
  void onInit() {
    super.onInit();
    fetchEvent();
  }

  Future<void> fetchEvent() async {
    isLoading.value = true;
    error.value = '';
    try {
      final fetched = await EventService().fetchEventById(eventId);
      event.value = fetched;
    } catch (e) {
      error.value = 'No se pudo cargar el evento';
    }
    isLoading.value = false;
  }

  Future<bool> deleteEvent() async {
    if (event.value == null) return false;
    try {
      final success = await EventService().deleteEvent(event.value!.id!);
      return success;
    } catch (_) {
      return false;
    }
  }
}
