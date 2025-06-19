import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/model/service/event_service.dart';

class EventsController extends GetxController {
  final RxList<Event> upcomingEvents = <Event>[].obs;
  final RxList<Event> pastEvents = <Event>[].obs;
  final RxBool isLoading = true.obs;

  DateTime? _parseEventDate(String? dateStr) {
    if (dateStr == null) return null;

    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      try {
        return DateFormat('dd/MM/yyyy').parse(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;

    try {
      final events = await EventService().fetchAllEvents();

      final now = DateTime.now();

      upcomingEvents.assignAll(
        events.where((e) {
          final eventDate = _parseEventDate(e.date);
          return eventDate != null && eventDate.isAfter(now);
        }),
      );

      pastEvents.assignAll(
        events.where((e) {
          final eventDate = _parseEventDate(e.date);
          return eventDate != null && eventDate.isBefore(now);
        }),
      );
    } catch (e) {
      upcomingEvents.clear();
      pastEvents.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
