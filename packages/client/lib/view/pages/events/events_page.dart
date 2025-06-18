import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/utils/event_format_utils.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/pages/events/create_edit_event_page.dart';
import 'package:jiron_anime/view/pages/events/single_event_page.dart';
import 'package:jiron_anime/viewmodel/controllers/events/events_controller.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventsController _controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    final colors = Get.theme.colorScheme;
    final theme = Get.theme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomLayout(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Eventos', style: theme.textTheme.titleLarge),

                  Row(
                    spacing: 8,
                    children: [
                      IconButton.filled(
                        color: colors.onPrimary,
                        style: IconButton.styleFrom(iconSize: 28),
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          final result = await Get.to(
                            () => const CreateEditEventPage(isEdit: false),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 300),
                          );

                          if (result == true) {
                            await _controller.fetchEvents();
                          }
                        },
                      ),

                      IconButton.filled(
                        color: colors.onPrimary,
                        icon: const Icon(Icons.filter_list_rounded),
                        style: IconButton.styleFrom(iconSize: 28),
                        onPressed: () {
                          Get.closeAllSnackbars();

                          Get.snackbar(
                            'Filtro',
                            'Función de filtro no implementada',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TabBar(
                  labelColor: colors.onPrimary,
                  unselectedLabelColor: colors.onPrimary.withValues(alpha: 0.7),
                  indicatorColor: colors.onPrimary,
                  dividerColor: Colors.transparent,
                  tabs: const [Tab(text: 'Próximos'), Tab(text: 'Pasados')],
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: Obx(
                  () =>
                      _controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : TabBarView(
                            children: [
                              _EventsList(events: _controller.upcomingEvents),
                              _EventsList(events: _controller.pastEvents),
                            ],
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: null,
    );
  }
}

class _EventsList extends StatelessWidget {
  final List<Event> events;
  const _EventsList({required this.events});

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final colors = theme.colorScheme;

    if (events.isEmpty) {
      return const Center(child: Text('No hay eventos.'));
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Column(
          children: [
            InkWell(
              onTap: () async {
                final result = await Get.to(
                  () => SingleEventPage(eventId: event.id?.toString() ?? ""),
                );
                final controller = Get.find<EventsController>();
                if (result == true) {
                  await controller.fetchEvents();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen con chips superpuestos
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child:
                              event.mainImageUrl != null &&
                                      event.mainImageUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                    imageUrl: event.mainImageUrl!,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => _ImagePlaceholder(),
                                    errorWidget:
                                        (context, url, error) =>
                                            _ImagePlaceholder(),
                                  )
                                  : _ImagePlaceholder(),
                        ),
                        // Chips en la esquina superior izquierda
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Row(
                            children: [
                              Chip(
                                label: Text(
                                  event.eventType?.name.toString() ?? '-',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colors.onPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: colors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: colors.primary),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(
                                  EventFormatUtils.getEventPriceLabel(
                                    event.isFree,
                                    event.price,
                                  ),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: colors.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: BorderSide(
                                  color: colors.primary,
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title ?? '-',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 18,
                                color: colors.onSurface.withValues(alpha: 0.7),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${event.date ?? ''}${event.time != null && event.time!.isNotEmpty ? ' – ${event.time}' : ''}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colors.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                EventFormatUtils.getEventLocationIcon(
                                  event.isVirtual,
                                  event.isOnCampus,
                                ),
                                size: 18,
                                color: colors.onSurface.withValues(alpha: 0.7),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  EventFormatUtils.getEventLocationLabel(event),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colors.onSurface.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Capacidad de personas
                          if (event.capacity != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.people_alt_rounded,
                                  size: 18,
                                  color: colors.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${event.capacity} personas',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colors.onSurface.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 12),
                          // Descripción (máx 2 líneas)
                          if (event.description != null &&
                              event.description!.isNotEmpty)
                            Text(
                              event.description!,
                              style: theme.textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (index != events.length - 1) const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Get.theme.colorScheme;
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: colors.onSurface.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}
