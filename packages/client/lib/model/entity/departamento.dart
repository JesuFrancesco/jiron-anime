//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'provincia.dart';
import 'distrito.dart';
import 'client.dart';

class Departamento implements ToJson, Id {
  @override
  int? id;
  String? name;
  List<Provincia>? provincias;
  List<Distrito>? distritos;
  List<Client>? clients;
  int? $provinciasCount;
  int? $distritosCount;
  int? $clientsCount;

  Departamento({
    this.id,
    this.name,
    this.provincias,
    this.distritos,
    this.clients,
    this.$provinciasCount,
    this.$distritosCount,
    this.$clientsCount,
  });

  factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
      id: json['id'] as int?,
      name: json['name'] as String?,
      provincias: json['provincias'] != null
          ? createModels<Provincia>(json['provincias'], Provincia.fromJson)
          : null,
      distritos: json['distritos'] != null
          ? createModels<Distrito>(json['distritos'], Distrito.fromJson)
          : null,
      clients: json['clients'] != null
          ? createModels<Client>(json['clients'], Client.fromJson)
          : null,
      $provinciasCount: json['_count']?['provincias'] as int?,
      $distritosCount: json['_count']?['distritos'] as int?,
      $clientsCount: json['_count']?['clients'] as int?);

  Departamento copyWith({
    int? id,
    String? name,
    List<Provincia>? provincias,
    List<Distrito>? distritos,
    List<Client>? clients,
    int? $provinciasCount,
    int? $distritosCount,
    int? $clientsCount,
  }) {
    return Departamento(
        id: id ?? this.id,
        name: name ?? this.name,
        provincias: provincias ?? this.provincias,
        distritos: distritos ?? this.distritos,
        clients: clients ?? this.clients,
        $provinciasCount: $provinciasCount ?? this.$provinciasCount,
        $distritosCount: $distritosCount ?? this.$distritosCount,
        $clientsCount: $clientsCount ?? this.$clientsCount);
  }

  Departamento copyWithInstance(Departamento departamento) {
    return Departamento(
        id: departamento.id ?? id,
        name: departamento.name ?? name,
        provincias: departamento.provincias ?? provincias,
        distritos: departamento.distritos ?? distritos,
        clients: departamento.clients ?? clients,
        $provinciasCount: departamento.$provinciasCount ?? $provinciasCount,
        $distritosCount: departamento.$distritosCount ?? $distritosCount,
        $clientsCount: departamento.$clientsCount ?? $clientsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (provincias != null)
          'provincias': provincias?.map((item) => item.toJson()).toList(),
        if (distritos != null)
          'distritos': distritos?.map((item) => item.toJson()).toList(),
        if (clients != null)
          'clients': clients?.map((item) => item.toJson()).toList(),
        if ($provinciasCount != null ||
            $distritosCount != null ||
            $clientsCount != null)
          '_count': {
            if ($provinciasCount != null) 'provincias': $provinciasCount,
            if ($distritosCount != null) 'distritos': $distritosCount,
            if ($clientsCount != null) 'clients': $clientsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Departamento &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          areListsEqual(provincias, other.provincias) &&
          areListsEqual(distritos, other.distritos) &&
          areListsEqual(clients, other.clients) &&
          $provinciasCount == other.$provinciasCount &&
          $distritosCount == other.$distritosCount &&
          $clientsCount == other.$clientsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      provincias.hashCode ^
      distritos.hashCode ^
      clients.hashCode ^
      $provinciasCount.hashCode ^
      $distritosCount.hashCode ^
      $clientsCount.hashCode;
}
