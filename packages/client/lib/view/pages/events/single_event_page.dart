import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/utils/event_format_utils.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:jiron_anime/view/pages/events/create_edit_event_page.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/viewmodel/controllers/events/single_event_controller.dart';

class SingleEventPage extends StatelessWidget {
  final String eventId;

  const SingleEventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final colors = theme.colorScheme;
    final SingleEventController c = Get.put(SingleEventController(eventId));
    bool wasEdited = false;

    return Obx(() {
      if (c.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // TODO: Cambiar por algo generico
      if (c.error.value.isNotEmpty) {
        return Center(child: Text(c.error.value));
      }

      final event = c.event.value;
      if (event == null) {
        return const Center(child: Text('Evento no encontrado'));
      }

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
              event.title ?? 'Evento',
              style: TextStyle(fontSize: 26),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (wasEdited) {
                  Navigator.of(context).pop(true);

                  return;
                }

                Navigator.of(context).pop();
              },
            ),
          ),
          body: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  event.mainImageUrl!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                10.pv,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              event.eventType?.name ?? '-',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.onPrimary,
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            visualDensity: VisualDensity.standard,
                          ),

                          10.ph,

                          Chip(
                            label: Text(
                              EventFormatUtils.getEventPriceLabel(
                                event.isFree,
                                event.price,
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.primary,
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: colors.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            side: BorderSide(color: colors.primary),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            visualDensity: VisualDensity.standard,
                          ),
                        ],
                      ),

                      10.pv,

                      Text(
                        event.title ?? '-',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colors.onSurface,
                          fontSize: 24,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      10.pv,

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 20,
                            color: colors.onSurface.withValues(alpha: 0.7),
                          ),

                          4.ph,

                          Expanded(
                            child: Text(
                              '${event.date ?? ''} \u2013 ${event.time ?? ''}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface.withValues(alpha: 0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      10.pv,

                      // Botón de Editar/Eliminar en caso sea el organizador
                      if (event.profileId == AuthService.getProfileId()) ...[
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () async {
                                  final result = await Get.to(
                                    () => CreateEditEventPage(
                                      event: event,
                                      isEdit: true,
                                    ),
                                    transition: Transition.cupertino,
                                    duration: const Duration(milliseconds: 300),
                                  );

                                  if (result == true) {
                                    await c.fetchEvent();

                                    wasEdited = true;

                                    Get.snackbar(
                                      'Evento actualizado',
                                      'Los datos del evento se actualizaron correctamente',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Editar'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: colors.primary,
                                  foregroundColor: colors.onPrimary,
                                  textStyle: theme.textTheme.labelLarge
                                      ?.copyWith(fontSize: 16),
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () async {
                                  final confirm = await Get.dialog<bool>(
                                    AlertDialog(
                                      title: const Text('Eliminar evento'),
                                      content: const Text(
                                        '¿Estás seguro de que deseas eliminar este evento? Esta acción no se puede deshacer.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Get.back(result: false),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Get.back(result: true),
                                          child: const Text(
                                            'Eliminar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    final success = await c.deleteEvent();
                                    if (success) {
                                      Get.back(
                                        result: true,
                                      ); // Regresa a la pantalla anterior
                                      Get.snackbar(
                                        'Evento eliminado',
                                        'El evento fue eliminado correctamente',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text('Eliminar'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  textStyle: theme.textTheme.labelLarge
                                      ?.copyWith(fontSize: 16),
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {},
                            label: const Text('Registrarse'),
                            icon: const Icon(
                              Icons.app_registration_outlined,
                              size: 20,
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                              textStyle: theme.textTheme.labelLarge?.copyWith(
                                fontSize: 16,
                              ),
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],

                      10.pv,
                    ],
                  ),
                ),

                10.pv,

                // TabBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      labelColor: colors.onPrimary,
                      unselectedLabelColor: colors.onPrimary.withValues(
                        alpha: 0.7,
                      ),
                      indicatorColor: colors.onPrimary,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'Información'),
                        Tab(text: 'Actividades'),
                        Tab(text: 'Detalles'),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      // Primer tab: Información
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Horario
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.access_time,
                                    size: 22,
                                    color: colors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Horario',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      event.time ?? '-',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurface.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Ubicación
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    EventFormatUtils.getEventLocationIcon(
                                      event.isVirtual,
                                      event.isOnCampus,
                                    ),
                                    size: 22,
                                    color: colors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ubicación',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      EventFormatUtils.getEventLocationLabel(
                                        event,
                                      ),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurface.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Descripción
                            Text(
                              'Descripción',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.description ?? '-',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface.withValues(alpha: 0.7),
                              ),
                            ),

                            20.pv,
                          ],
                        ),
                      ),
                      // Segundo tab: Actividades
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Actividades del Evento',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),

                            const SizedBox(height: 16),

                            if (event.activities != null &&
                                event.activities!.isNotEmpty)
                              ...event.activities!.map(
                                (act) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 16),
                                      const Text(
                                        '•',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          act,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            if (event.activities == null ||
                                event.activities!.isEmpty)
                              const Text('No hay actividades registradas.'),
                          ],
                        ),
                      ),

                      // Tercer tab: Detalles
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Organizador
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    'https://randomuser.me/api/portraits/women/44.jpg',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Organizador',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      event.profileId ?? '-',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurface.withValues(
                                              alpha: 0.6,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            Divider(
                              thickness: 1,
                              color: colors.primary.withValues(alpha: 0.2),
                            ),

                            const SizedBox(height: 8),

                            // Duración y Capacidad
                            Row(
                              children: [
                                // Duración
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Duración',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        event.duration != null
                                            ? '${event.duration} minutos'
                                            : '-',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: colors.onSurface
                                                  .withValues(alpha: 0.7),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Capacidad
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Capacidad',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),

                                      Text(
                                        event.capacity != null
                                            ? '${event.capacity} personas'
                                            : '-',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: colors.onSurface
                                                  .withValues(alpha: 0.7),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
