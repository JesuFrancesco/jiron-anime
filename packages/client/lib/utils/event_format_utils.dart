import 'package:flutter/material.dart';
import 'package:jiron_anime/model/entity/events/event.dart';

class EventFormatUtils {
  static String getEventPriceLabel(bool? isFree, double? price) {
    if (isFree == true) return 'Gratis';

    if (price != null) return 'S/ ${price.toStringAsFixed(2)}';

    return '-';
  }

  static IconData getEventLocationIcon(bool? isVirtual, bool? isOnCampus) {
    if (isVirtual == true) return Icons.wifi;

    if (isOnCampus == true) return Icons.location_city;

    return Icons.location_on_rounded;
  }

  static String getEventLocationLabel(Event event) {
    if (event.isVirtual == true) return 'Virtual';

    if (event.isOnCampus == true) {
      final edificio = event.edificio?.trim();
      final salon = event.salon?.trim();
      if ((edificio?.isNotEmpty ?? false) && (salon?.isNotEmpty ?? false)) {
        // El \u2013 es un guion largo
        return '$edificio \u2013 $salon';
      } else if (edificio?.isNotEmpty ?? false) {
        return edificio!;
      } else if (salon?.isNotEmpty ?? false) {
        return salon!;
      } else {
        return 'En campus';
      }
    }
    return event.location?.isNotEmpty == true ? event.location! : '-';
  }
}
