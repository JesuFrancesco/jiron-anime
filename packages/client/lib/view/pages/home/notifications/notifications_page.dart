import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';
import 'package:jiron_anime/viewmodel/controllers/notifications_controller.dart';
import 'package:jiron_anime/model/entity/notification.dart';
import 'package:jiron_anime/view/pages/home/notifications/widget/notification_widget.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notificationController = Get.put(NotificationsController());
  RxList<Notification> get items => notificationController.notificaciones;

  Future<void> fetchNotifications() async {
    await notificationController.obtenerNotificaciones();
  }

  void eliminarNotificacion(int index) {
    items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: RefreshIndicator(
          onRefresh: fetchNotifications,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Obx(
                  () => Column(
                    children: [
                      const CustomAppbar(title: "Notificaciones"),
                      15.pv,
                      notificationController.isLoading.value
                          ? const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : Builder(
                            builder: (context) {
                              if (notificationController
                                  .notificaciones
                                  .isEmpty) {
                                return Expanded(
                                  child: Center(
                                    child: Text(
                                      "No tienes notificaciones...",
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                  ),
                                );
                              }

                              return Column(
                                children:
                                    items.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final item = entry.value;

                                      return NotificacionRemovableWidget(
                                        item: item,
                                        onDismissed:
                                            () => eliminarNotificacion(index),
                                      );
                                    }).toList(),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
