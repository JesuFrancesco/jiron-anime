import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/model/service/event_service.dart';
import 'package:jiron_anime/model/service/auth_service.dart';

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

  Future<bool> registerToEvent() async {
    if (event.value == null) return false;

    try {
      final success = await EventService().registerToEvent(event.value!.id!);

      return success;
    } catch (_) {
      return false;
    }
  }

  // TODO: pasar formateo a utils
  bool checkIfEventIsPast() {
    if (event.value == null || event.value!.date == null) return false;

    final eventDate = DateFormat('dd/MM/yyyy').parse(event.value!.date!);

    return eventDate.isBefore(DateTime.now());
  }

  // Verifica si el usuario actual está registrado en el evento
  bool isUserRegistered() {
    final attendees = event.value?.attendees;
    if (attendees == null) return false;
    final currentProfileId = AuthService.getProfileId();
    return attendees.any((a) => a.profileId == currentProfileId);
  }

  // Cancela el registro del usuario actual en el evento
  Future<bool> unregisterFromEvent() async {
    if (event.value == null) return false;
    try {
      final attendees = event.value!.attendees;
      final currentProfileId = AuthService.getProfileId();
      final found = attendees?.firstWhereOrNull(
        (a) => a.profileId == currentProfileId,
      );
      if (found == null) return false;
      final success = await EventService().unregisterFromEvent(found.id);
      return success;
    } catch (_) {
      return false;
    }
  }
}
