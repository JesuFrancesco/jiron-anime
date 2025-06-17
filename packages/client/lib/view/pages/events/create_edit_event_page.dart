import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/view/pages/events/widgets/create_edit_event_form.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/viewmodel/controllers/events/create_edit_event_controller.dart';

class CreateEditEventPage extends StatelessWidget {
  final Event? event;
  final bool isEdit;

  const CreateEditEventPage({super.key, this.event, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    // Usar un tag único para evitar conflictos si se abren varias páginas
    final tag = hashCode.toString();
    final controller = Get.put(
      CreateEditEventController(initialEvent: event),
      tag: tag,
    );
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.5, 1],
          colors: AppColors.backgroundLinearGradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            isEdit ? 'Editar Evento' : 'Crear Evento',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: CreateEditEventForm(
            c: controller,
            isEdit: isEdit,
            initialEvent: event,
          ),
        ),
      ),
    );
  }
}
