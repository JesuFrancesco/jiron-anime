//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'brand_seller.dart';
import 'client.dart';

class Country implements ToJson, Id {
  @override
  int? id;
  String? name;
  String? code;
  List<BrandSeller>? brandSellers;
  List<Client>? clients;
  int? $brandSellersCount;
  int? $clientsCount;

  Country({
    this.id,
    this.name,
    this.code,
    this.brandSellers,
    this.clients,
    this.$brandSellersCount,
    this.$clientsCount,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      brandSellers: json['brandSellers'] != null
          ? createModels<BrandSeller>(
              json['brandSellers'], BrandSeller.fromJson)
          : null,
      clients: json['clients'] != null
          ? createModels<Client>(json['clients'], Client.fromJson)
          : null,
      $brandSellersCount: json['_count']?['brandSellers'] as int?,
      $clientsCount: json['_count']?['clients'] as int?);

  Country copyWith({
    int? id,
    String? name,
    String? code,
    List<BrandSeller>? brandSellers,
    List<Client>? clients,
    int? $brandSellersCount,
    int? $clientsCount,
  }) {
    return Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        brandSellers: brandSellers ?? this.brandSellers,
        clients: clients ?? this.clients,
        $brandSellersCount: $brandSellersCount ?? this.$brandSellersCount,
        $clientsCount: $clientsCount ?? this.$clientsCount);
  }

  Country copyWithInstance(Country country) {
    return Country(
        id: country.id ?? id,
        name: country.name ?? name,
        code: country.code ?? code,
        brandSellers: country.brandSellers ?? brandSellers,
        clients: country.clients ?? clients,
        $brandSellersCount: country.$brandSellersCount ?? $brandSellersCount,
        $clientsCount: country.$clientsCount ?? $clientsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (code != null) 'code': code,
        if (brandSellers != null)
          'brandSellers': brandSellers?.map((item) => item.toJson()).toList(),
        if (clients != null)
          'clients': clients?.map((item) => item.toJson()).toList(),
        if ($brandSellersCount != null || $clientsCount != null)
          '_count': {
            if ($brandSellersCount != null) 'brandSellers': $brandSellersCount,
            if ($clientsCount != null) 'clients': $clientsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code &&
          areListsEqual(brandSellers, other.brandSellers) &&
          areListsEqual(clients, other.clients) &&
          $brandSellersCount == other.$brandSellersCount &&
          $clientsCount == other.$clientsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      brandSellers.hashCode ^
      clients.hashCode ^
      $brandSellersCount.hashCode ^
      $clientsCount.hashCode;
}
