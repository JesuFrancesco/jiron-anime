//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'departamento.dart';
import 'distrito.dart';
import 'client.dart';

class Provincia implements ToJson, Id {
  @override
  int? id;
  String? name;
  int? departamentoId;
  Departamento? departamento;
  List<Distrito>? distritos;
  List<Client>? clients;
  int? $distritosCount;
  int? $clientsCount;

  Provincia({
    this.id,
    this.name,
    this.departamentoId,
    this.departamento,
    this.distritos,
    this.clients,
    this.$distritosCount,
    this.$clientsCount,
  });

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
      id: json['id'] as int?,
      name: json['name'] as String?,
      departamentoId: json['departamentoId'] as int?,
      departamento: json['departamento'] != null
          ? Departamento.fromJson(json['departamento'] as Map<String, dynamic>)
          : null,
      distritos: json['distritos'] != null
          ? createModels<Distrito>(json['distritos'], Distrito.fromJson)
          : null,
      clients: json['clients'] != null
          ? createModels<Client>(json['clients'], Client.fromJson)
          : null,
      $distritosCount: json['_count']?['distritos'] as int?,
      $clientsCount: json['_count']?['clients'] as int?);

  Provincia copyWith({
    int? id,
    String? name,
    int? departamentoId,
    Departamento? departamento,
    List<Distrito>? distritos,
    List<Client>? clients,
    int? $distritosCount,
    int? $clientsCount,
  }) {
    return Provincia(
        id: id ?? this.id,
        name: name ?? this.name,
        departamentoId: departamentoId ?? this.departamentoId,
        departamento: departamento ?? this.departamento,
        distritos: distritos ?? this.distritos,
        clients: clients ?? this.clients,
        $distritosCount: $distritosCount ?? this.$distritosCount,
        $clientsCount: $clientsCount ?? this.$clientsCount);
  }

  Provincia copyWithInstance(Provincia provincia) {
    return Provincia(
        id: provincia.id ?? id,
        name: provincia.name ?? name,
        departamentoId: provincia.departamentoId ?? departamentoId,
        departamento: provincia.departamento ?? departamento,
        distritos: provincia.distritos ?? distritos,
        clients: provincia.clients ?? clients,
        $distritosCount: provincia.$distritosCount ?? $distritosCount,
        $clientsCount: provincia.$clientsCount ?? $clientsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (departamentoId != null) 'departamentoId': departamentoId,
        if (departamento != null) 'departamento': departamento,
        if (distritos != null)
          'distritos': distritos?.map((item) => item.toJson()).toList(),
        if (clients != null)
          'clients': clients?.map((item) => item.toJson()).toList(),
        if ($distritosCount != null || $clientsCount != null)
          '_count': {
            if ($distritosCount != null) 'distritos': $distritosCount,
            if ($clientsCount != null) 'clients': $clientsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Provincia &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          departamentoId == other.departamentoId &&
          departamento == other.departamento &&
          areListsEqual(distritos, other.distritos) &&
          areListsEqual(clients, other.clients) &&
          $distritosCount == other.$distritosCount &&
          $clientsCount == other.$clientsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      departamentoId.hashCode ^
      departamento.hashCode ^
      distritos.hashCode ^
      clients.hashCode ^
      $distritosCount.hashCode ^
      $clientsCount.hashCode;
}
