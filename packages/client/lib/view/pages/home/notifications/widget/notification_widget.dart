import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/notification.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';

class NotificacionRemovableWidget extends StatelessWidget {
  final Notification item;
  final VoidCallback onDismissed;

  const NotificacionRemovableWidget({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _handlerMostrarImagenCompleta(context),
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color:
                        Colors.white..withValues(
                          alpha: 0.3,
                        ), // Semi-transparent white background
                    child: const Center(
                      child: Icon(
                        Icons.help_outline,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    8.pv,
                    Text(item.description!, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlerMostrarImagenCompleta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black..withValues(alpha: 0.8),
          body: Stack(
            children: [
              Center(
                child: Image.network(
                  item.imageUrl!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color:
                          Colors.white..withValues(
                            alpha: 0.3,
                          ), // Semi-transparent white background
                      child: const Center(
                        child: Icon(
                          Icons.help_outline,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
