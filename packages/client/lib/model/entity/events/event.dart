import 'package:jiron_anime/model/entity/events/event_type.dart';
import 'package:jiron_anime/model/entity/model_base.dart';

class Event implements ToJson {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? title;
  String? description;
  int? eventTypeId;
  EventType? eventType;

  String? date;
  String? time;
  int? duration;
  int? capacity;

  bool? isVirtual;
  bool? isOnCampus;
  String? edificio;
  String? salon;
  String? location;
  String? link;

  bool? isFree;
  double? price;

  String? mainImageUrl;

  List<String>? activities;

  String? profileId;

  Event({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.eventTypeId,
    this.eventType,
    this.date,
    this.time,
    this.duration,
    this.capacity,
    this.isVirtual,
    this.isOnCampus,
    this.edificio,
    this.salon,
    this.location,
    this.link,
    this.isFree,
    this.price,
    this.mainImageUrl,
    this.activities,
    this.profileId,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'] as int?,
    createdAt:
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    title: json['title'] as String?,
    description: json['description'] as String?,
    eventTypeId: json['eventTypeId'] as int?,
    eventType:
        json['eventType'] != null
            ? EventType.fromJson(json['eventType'] as Map<String, dynamic>)
            : null,
    date: json['date'] as String?,
    time: json['time'] as String?,
    duration: json['duration'] as int?,
    capacity: json['capacity'] as int?,
    isVirtual: json['isVirtual'] as bool?,
    isOnCampus: json['isOnCampus'] as bool?,
    edificio: json['edificio'] as String?,
    salon: json['salon'] as String?,
    location: json['location'] as String?,
    link: json['link'] as String?,
    isFree: json['isFree'] as bool?,
    price: (json['price'] as num?)?.toDouble(),
    mainImageUrl: json['mainImageUrl'] as String?,
    activities:
        (json['activities'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
    profileId: json['profileId'] as String?,
  );

  @override
  Map<String, dynamic> toJson() => ({
    if (id != null) 'id': id,
    if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    if (title != null) 'title': title,
    if (description != null) 'description': description,
    if (eventTypeId != null) 'eventTypeId': eventTypeId,
    if (eventType != null) 'eventType': eventType!.toJson(),
    if (date != null) 'date': date,
    if (time != null) 'time': time,
    if (duration != null) 'duration': duration,
    if (capacity != null) 'capacity': capacity,
    if (isVirtual != null) 'isVirtual': isVirtual,
    if (isOnCampus != null) 'isOnCampus': isOnCampus,
    if (edificio != null) 'edificio': edificio,
    if (salon != null) 'salon': salon,
    if (location != null) 'location': location,
    if (link != null) 'link': link,
    if (isFree != null) 'isFree': isFree,
    if (price != null) 'price': price,
    if (mainImageUrl != null) 'mainImageUrl': mainImageUrl,
    if (activities != null) 'activities': activities,
    if (profileId != null) 'profileId': profileId,
  });
}
