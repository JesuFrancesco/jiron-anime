import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/model/entity/events/event_type.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/model/service/file_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:jiron_anime/model/service/event_service.dart';

class CreateEditEventController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final mainImage = Rx<File?>(null);
  final picker = ImagePicker();
  final EventService _eventService = EventService();

  // Observables para los campos
  final title = ''.obs;
  final eventTypeId = RxnInt();
  final eventTypeName = RxnString();
  final date = ''.obs;
  final time = ''.obs;
  final duration = 0.obs;
  final capacity = 0.obs;
  final building = ''.obs;
  final room = ''.obs;
  final price = ''.obs;
  final description = ''.obs;
  final accessLink = ''.obs;
  final externalLocation = ''.obs;
  final modality = 'Presencial'.obs;
  final location = 'Dentro de la Universidad'.obs;
  final isFree = false.obs;
  final activities = <List<String>>[].obs;

  // Controlador para el input de actividades
  final TextEditingController activityInputController = TextEditingController();

  // Observables para tipos de evento
  final eventTypes = <EventType>[].obs;
  final isLoadingEventTypes = true.obs;
  final eventTypesError = RxnString();

  final Event? initialEvent;

  // Observable para controlar la visibilidad de la imagen inicial
  final RxBool showInitialImage = true.obs;

  CreateEditEventController({this.initialEvent});

  @override
  void onInit() {
    super.onInit();
    _loadEventTypes();

    if (initialEvent != null) {
      populateFromEvent(initialEvent!);
    }
  }

  @override
  void onClose() {
    activityInputController.dispose();
    super.onClose();
  }

  Future<void> _loadEventTypes() async {
    isLoadingEventTypes.value = true;
    eventTypesError.value = null;
    try {
      final types = await _eventService.fetchActiveEventTypes();
      eventTypes.assignAll(types);
    } catch (e) {
      eventTypesError.value = e.toString();
    } finally {
      isLoadingEventTypes.value = false;
    }
  }

  Future<void> pickMainImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      mainImage.value = File(pickedFile.path);
    }
  }

  void addActivity() {
    final text = activityInputController.text.trim();
    if (text.isNotEmpty) {
      activities.add([text]);
      activityInputController.clear();
    }
  }

  void deleteActivity(int index) {
    activities.removeAt(index);
  }

  void populateFromEvent(Event event) {
    title.value = event.title ?? '';
    description.value = event.description ?? '';
    date.value = event.date ?? '';
    time.value = event.time ?? '';
    duration.value = event.duration ?? 0;
    capacity.value = event.capacity ?? 0;
    eventTypeId.value = event.eventTypeId;
    eventTypeName.value = event.eventType?.name;
    building.value = event.edificio ?? '';
    room.value = event.salon ?? '';
    price.value = event.price?.toString() ?? '';
    accessLink.value = event.link ?? '';
    externalLocation.value = event.location ?? '';
    activities.assignAll((event.activities ?? []).map((act) => [act]));
    modality.value = event.isVirtual == true ? 'Virtual' : 'Presencial';
    location.value =
        event.isOnCampus == true
            ? 'Dentro de la Universidad'
            : 'Fuera de la Universidad';
    isFree.value = event.isFree ?? false;
    mainImage.value = null;
  }

  void deleteImage() {
    mainImage.value = null;
    if (initialEvent != null && initialEvent!.mainImageUrl != null) {
      showInitialImage.value = false;
      // TODO: Implementar lógica para borrar la imagen del storage de Supabase
    }
  }

  Future<void> submitForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (mainImage.value == null &&
        (initialEvent == null || initialEvent?.mainImageUrl == null)) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Imagen requerida',
        'Por favor, selecciona la imagen principal del evento',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    String? newImageUrl = initialEvent?.mainImageUrl;
    if (mainImage.value != null) {
      final uploadService = FileUploadService(context);
      final uploadFile = await uploadService.uploadSingleFile(mainImage.value!);
      newImageUrl = uploadFile?.publicUrl;
    }

    final newEvent = Event(
      title: title.value,
      description: description.value,
      date: date.value,
      time: time.value,
      duration: duration.value,
      capacity: capacity.value,
      eventTypeId: eventTypeId.value,
      mainImageUrl: newImageUrl,
      profileId: AuthService.getProfileId(),
      activities: activities.map((act) => act[0]).toList(),
      isVirtual: modality.value == 'Virtual',
      isOnCampus: location.value == 'Dentro de la Universidad',
      edificio:
          modality.value == 'Virtual'
              ? null
              : location.value == 'Dentro de la Universidad'
              ? building.value
              : null,
      salon:
          modality.value == 'Virtual'
              ? null
              : location.value == 'Dentro de la Universidad'
              ? room.value
              : null,
      location:
          modality.value == 'Virtual'
              ? null
              : location.value == 'Dentro de la Universidad'
              ? null
              : externalLocation.value,
      link: modality.value == 'Virtual' ? accessLink.value : null,
      isFree: isFree.value,
      price: isFree.value ? null : double.tryParse(price.value),
    );

    // Verifica si es una edición o creación de evento
    if (initialEvent != null) {
      print('Actualizando evento: ${newEvent.toJson()}');
      return;
      // await _eventService.updateEvent(newEvent);
    } else {
      await _eventService.createNewEvent(newEvent);
    }

    Get.closeAllSnackbars();
    Get.snackbar(
      'Éxito',
      initialEvent == null
          ? 'Evento creado exitosamente'
          : 'Evento editado exitosamente',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );

    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
