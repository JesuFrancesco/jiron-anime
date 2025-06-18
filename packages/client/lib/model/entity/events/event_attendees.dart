class EventAttendees {
  String id;
  int eventId;
  String profileId;
  DateTime createdAt;

  EventAttendees({
    required this.id,
    required this.eventId,
    required this.profileId,
    required this.createdAt,
  });

  factory EventAttendees.fromJson(Map<String, dynamic> json) {
    return EventAttendees(
      id: json["id"],
      eventId: json["eventId"],
      profileId: json["profileId"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "eventId": eventId,
      "profileId": profileId,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
