import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import '../entity/notification.dart';

class NotificationsService {
  Future<List<Notification>> fetchAll() async {
    List<Notification> notificaciones = [];
    final res = await http.get(Uri.parse("${Config.apiUrl}/notification"));

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      throw Error();
    }

    final List<dynamic> data = jsonDecode(res.body);
    notificaciones =
        data
            .map((map) => Notification.fromJson(map as Map<String, dynamic>))
            .toList();

    return notificaciones;
  }
}
