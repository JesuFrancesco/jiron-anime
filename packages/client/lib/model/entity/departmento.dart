//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'provincia.dart';
import 'user.dart';

class Departmento implements ToJson, Id {
  @override
  int? id;
  String? name;
  List<Provincia>? provincias;
  List<User>? users;
  int? $provinciasCount;
  int? $usersCount;

  Departmento({
    this.id,
    this.name,
    this.provincias,
    this.users,
    this.$provinciasCount,
    this.$usersCount,
  });

  factory Departmento.fromJson(Map<String, dynamic> json) => Departmento(
      id: json['id'] as int?,
      name: json['name'] as String?,
      provincias: json['provincias'] != null
          ? createModels<Provincia>(json['provincias'], Provincia.fromJson)
          : null,
      users: json['users'] != null
          ? createModels<User>(json['users'], User.fromJson)
          : null,
      $provinciasCount: json['_count']?['provincias'] as int?,
      $usersCount: json['_count']?['users'] as int?);

  Departmento copyWith({
    int? id,
    String? name,
    List<Provincia>? provincias,
    List<User>? users,
    int? $provinciasCount,
    int? $usersCount,
  }) {
    return Departmento(
        id: id ?? this.id,
        name: name ?? this.name,
        provincias: provincias ?? this.provincias,
        users: users ?? this.users,
        $provinciasCount: $provinciasCount ?? this.$provinciasCount,
        $usersCount: $usersCount ?? this.$usersCount);
  }

  Departmento copyWithInstance(Departmento departmento) {
    return Departmento(
        id: departmento.id ?? id,
        name: departmento.name ?? name,
        provincias: departmento.provincias ?? provincias,
        users: departmento.users ?? users,
        $provinciasCount: departmento.$provinciasCount ?? $provinciasCount,
        $usersCount: departmento.$usersCount ?? $usersCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (provincias != null)
          'provincias': provincias?.map((item) => item.toJson()).toList(),
        if (users != null)
          'users': users?.map((item) => item.toJson()).toList(),
        if ($provinciasCount != null || $usersCount != null)
          '_count': {
            if ($provinciasCount != null) 'provincias': $provinciasCount,
            if ($usersCount != null) 'users': $usersCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Departmento &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          areListsEqual(provincias, other.provincias) &&
          areListsEqual(users, other.users) &&
          $provinciasCount == other.$provinciasCount &&
          $usersCount == other.$usersCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      provincias.hashCode ^
      users.hashCode ^
      $provinciasCount.hashCode ^
      $usersCount.hashCode;
}
