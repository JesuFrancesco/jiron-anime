import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/utils/event_format_utils.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/pages/events/create_edit_event_page.dart';
import 'package:jiron_anime/view/pages/events/single_event_page.dart';
import 'package:jiron_anime/viewmodel/controllers/events/events_controller.dart';

// TODO: Agregar paginación
class OrderItem {
  final String label;
  final String value;

  OrderItem({required this.label, required this.value});
}

List<OrderItem> orderItems = [
  OrderItem(label: 'Fecha próxima', value: 'next_date'),
  OrderItem(label: 'Popular', value: 'popular'),
  OrderItem(label: 'Precio (Menor a Mayor)', value: 'price'),
  OrderItem(label: 'Precio (Mayor a Menor)', value: 'price'),
];

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final TextEditingController _orderByController = TextEditingController();
  OrderItem _selectedOrder = orderItems.first;

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
                      // TODO: Pasarlo como FAB
                      IconButton.filled(
                        color: colors.onPrimary,
                        style: IconButton.styleFrom(iconSize: 28),
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          final result = await Get.to(
                            () => CreateEditEventPage(isEdit: false),
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

              18.pv,

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

              18.pv,

              // TODO: Cambiar por buscador y mover a filtros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Ordenar por:'),
                  10.ph,
                  DropdownMenu<OrderItem>(
                    initialSelection: orderItems.first,
                    controller: _orderByController,
                    width: context.width * 0.4,
                    enableSearch: false,
                    onSelected: (value) {
                      if (value == null) return;

                      _selectedOrder = value;

                      print('Orden seleccionado: ${value.label}');
                    },
                    dropdownMenuEntries:
                        orderItems
                            .map(
                              (item) => DropdownMenuEntry<OrderItem>(
                                value: item,
                                label: item.label,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),

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

    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final event = events[index];
        return InkWell(
          onTap: () async {
            final result = await Get.to(
              () => SingleEventPage(eventId: event.id?.toString() ?? ""),
            );

            final controller = Get.find<EventsController>();

            if (result == true) {
              await controller.fetchEvents();
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageWidth = constraints.maxWidth * 0.4;

              return Container(
                height: 150,
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.outline.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: imageWidth,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ResizeImage(
                            NetworkImage(event.mainImageUrl!),
                            width: imageWidth.round(),
                            height: 120,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Chip(
                                  label: Text(
                                    event.eventType?.name.toString() ?? '-',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: colors.onPrimary,
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
                                  visualDensity: VisualDensity.compact,
                                ),

                                8.ph,

                                Chip(
                                  label: Text(
                                    EventFormatUtils.getEventPriceLabel(
                                      event.isFree,
                                      event.price,
                                    ),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: colors.primary,
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
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ),

                            Text(
                              event.title ?? '-',
                              style: theme.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            4.pv,

                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 16,
                                  color: colors.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),

                                4.ph,

                                Expanded(
                                  child: Text(
                                    // \u2013 es un guion largo
                                    '${event.date ?? ''} \u2013 ${event.time ?? ''}',
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

                            4.pv,

                            Row(
                              children: [
                                Icon(
                                  EventFormatUtils.getEventLocationIcon(
                                    event.isVirtual,
                                    event.isOnCampus,
                                  ),
                                  size: 16,
                                  color: colors.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),

                                4.ph,

                                Expanded(
                                  child: Text(
                                    EventFormatUtils.getEventLocationLabel(
                                      event,
                                    ),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
