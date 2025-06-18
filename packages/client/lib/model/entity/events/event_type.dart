class EventType {
  int id;
  String name;
  bool active;

  EventType({required this.id, required this.name, required this.active});

  factory EventType.fromJson(Map<String, dynamic> json) =>
      EventType(id: json["id"], name: json["name"], active: json["active"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "active": active};
}
