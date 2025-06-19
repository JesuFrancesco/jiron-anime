import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/model/entity/events/event_type.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

class EventService {
  Future<List<EventType>> fetchActiveEventTypes() async {
    List<EventType> eventTypes = [];

    final queryParams = {"where[active]": true};

    final res = await http.get(
      Uri.parse(
        "${Config.apiUrl}/eventtype?${parseToQueryParams(queryParams)}",
      ),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);
    eventTypes =
        data
            .map((map) => EventType.fromJson(map as Map<String, dynamic>))
            .toList();

    return eventTypes;
  }

  Future<Event> createNewEvent(Event evento) async {
    final res = await http.post(
      Uri.parse("${Config.apiUrl}/event"),
      body: json.encode({"data": evento.toJson()}),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);

    return Event.fromJson(data);
  }

  Future<List<Event>> fetchAllEvents({int? limit, int? offset}) async {
    List<Event> eventos = [];

    final queryParams = {
      "orderBy[createdAt]": "desc",

      // Seleccionar solo los campos necesarios
      "select[id]": true,
      "select[title]": true,
      "select[description]": true,
      "select[capacity]": true,
      "select[date]": true,
      "select[time]": true,
      "select[isVirtual]": true,
      "select[isOnCampus]": true,
      "select[edificio]": true,
      "select[salon]": true,
      "select[location]": true,
      "select[isFree]": true,
      "select[price]": true,
      "select[mainImageUrl]": true,

      // Relación a la tabla EventType
      "select[eventType]": true,
    };

    final res = await http.get(
      Uri.parse("${Config.apiUrl}/event?${parseToQueryParams(queryParams)}"),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);
    eventos =
        data.map((map) => Event.fromJson(map as Map<String, dynamic>)).toList();

    return eventos;
  }

  Future<Event> fetchEventById(String id) async {
    final queryParam = {
      "where[id]": id,

      // Seleccionar solo los campos necesarios
      "select[id]": true,
      "select[title]": true,
      "select[mainImageUrl]": true,
      "select[isFree]": true,
      "select[price]": true,
      "select[date]": true,
      "select[time]": true,
      "select[profileId]": true,
      "select[isVirtual]": true,
      "select[isOnCampus]": true,
      "select[description]": true,
      "select[activities]": true,
      "select[duration]": true,
      "select[capacity]": true,
      "select[edificio]": true,
      "select[salon]": true,
      "select[location]": true,
      "select[eventTypeId]": true,

      // Relación a otras tablas
      "select[attendees]": true,
      "select[eventType]": true,
      "select[profile]": true,
      // "select[profile][select][email]": true,
      // "select[eventType][select][name]": true,
      // "select[attendees][select][profileId]": true,
    };

    final res = await http.get(
      Uri.parse(
        "${Config.apiUrl}/event/unique?${parseToQueryParams(queryParam)}",
      ),
      headers: getSupabaseAuthHeaders(),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);
    return Event.fromJson(data as Map<String, dynamic>);
  }

  Future<bool> deleteEvent(int id) async {
    final encodedBody = json.encode({
      "where": {"id": id},
    });

    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/event"),
      body: encodedBody,
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
      return false;
    }

    return true;
  }

  Future<Event> updateEvent(Event evento) async {
    final encodedBody = json.encode({
      "data": evento.toJson(),
      "where": {"id": evento.id},
    });

    final res = await http.put(
      Uri.parse("${Config.apiUrl}/event"),
      body: encodedBody,
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);
    return Event.fromJson(data as Map<String, dynamic>);
  }

  Future<bool> registerToEvent(int eventId) async {
    final encodedBody = json.encode({
      "data": {"eventId": eventId, "profileId": AuthService.getProfileId()},
    });

    final res = await http.post(
      Uri.parse("${Config.apiUrl}/eventattendee"),
      body: encodedBody,
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
      return false;
    }

    return true;
  }

  Future<bool> unregisterFromEvent(String attendeeId) async {
    final encodedBody = json.encode({
      "where": {"id": attendeeId},
    });

    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/eventattendee"),
      body: encodedBody,
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );
    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
      return false;
    }
    return true;
  }
}
