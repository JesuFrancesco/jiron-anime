//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'provincia.dart';
import 'departamento.dart';
import 'client.dart';

class Distrito implements ToJson, Id {
  @override
  int? id;
  String? name;
  int? provinciaId;
  Provincia? provincia;
  int? departamentoId;
  Departamento? departamento;
  List<Client>? clients;
  int? $clientsCount;

  Distrito({
    this.id,
    this.name,
    this.provinciaId,
    this.provincia,
    this.departamentoId,
    this.departamento,
    this.clients,
    this.$clientsCount,
  });

  factory Distrito.fromJson(Map<String, dynamic> json) => Distrito(
      id: json['id'] as int?,
      name: json['name'] as String?,
      provinciaId: json['provinciaId'] as int?,
      provincia: json['provincia'] != null
          ? Provincia.fromJson(json['provincia'] as Map<String, dynamic>)
          : null,
      departamentoId: json['departamentoId'] as int?,
      departamento: json['departamento'] != null
          ? Departamento.fromJson(json['departamento'] as Map<String, dynamic>)
          : null,
      clients: json['clients'] != null
          ? createModels<Client>(json['clients'], Client.fromJson)
          : null,
      $clientsCount: json['_count']?['clients'] as int?);

  Distrito copyWith({
    int? id,
    String? name,
    int? provinciaId,
    Provincia? provincia,
    int? departamentoId,
    Departamento? departamento,
    List<Client>? clients,
    int? $clientsCount,
  }) {
    return Distrito(
        id: id ?? this.id,
        name: name ?? this.name,
        provinciaId: provinciaId ?? this.provinciaId,
        provincia: provincia ?? this.provincia,
        departamentoId: departamentoId ?? this.departamentoId,
        departamento: departamento ?? this.departamento,
        clients: clients ?? this.clients,
        $clientsCount: $clientsCount ?? this.$clientsCount);
  }

  Distrito copyWithInstance(Distrito distrito) {
    return Distrito(
        id: distrito.id ?? id,
        name: distrito.name ?? name,
        provinciaId: distrito.provinciaId ?? provinciaId,
        provincia: distrito.provincia ?? provincia,
        departamentoId: distrito.departamentoId ?? departamentoId,
        departamento: distrito.departamento ?? departamento,
        clients: distrito.clients ?? clients,
        $clientsCount: distrito.$clientsCount ?? $clientsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (provinciaId != null) 'provinciaId': provinciaId,
        if (provincia != null) 'provincia': provincia,
        if (departamentoId != null) 'departamentoId': departamentoId,
        if (departamento != null) 'departamento': departamento,
        if (clients != null)
          'clients': clients?.map((item) => item.toJson()).toList(),
        if ($clientsCount != null)
          '_count': {
            if ($clientsCount != null) 'clients': $clientsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Distrito &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          provinciaId == other.provinciaId &&
          provincia == other.provincia &&
          departamentoId == other.departamentoId &&
          departamento == other.departamento &&
          areListsEqual(clients, other.clients) &&
          $clientsCount == other.$clientsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      provinciaId.hashCode ^
      provincia.hashCode ^
      departamentoId.hashCode ^
      departamento.hashCode ^
      clients.hashCode ^
      $clientsCount.hashCode;
}
