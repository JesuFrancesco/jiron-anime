//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'country.dart';
import 'product.dart';

class BrandSeller implements ToJson, Id {
  @override
  int? id;
  String? name;
  String? description;
  String? referenceLocation;
  int? countryId;
  Country? country;
  List<Product>? products;
  int? $productsCount;

  BrandSeller({
    this.id,
    this.name,
    this.description,
    this.referenceLocation,
    this.countryId,
    this.country,
    this.products,
    this.$productsCount,
  });

  factory BrandSeller.fromJson(Map<String, dynamic> json) => BrandSeller(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      referenceLocation: json['referenceLocation'] as String?,
      countryId: json['countryId'] as int?,
      country: json['country'] != null
          ? Country.fromJson(json['country'] as Map<String, dynamic>)
          : null,
      products: json['products'] != null
          ? createModels<Product>(json['products'], Product.fromJson)
          : null,
      $productsCount: json['_count']?['products'] as int?);

  BrandSeller copyWith({
    int? id,
    String? name,
    String? description,
    String? referenceLocation,
    int? countryId,
    Country? country,
    List<Product>? products,
    int? $productsCount,
  }) {
    return BrandSeller(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        referenceLocation: referenceLocation ?? this.referenceLocation,
        countryId: countryId ?? this.countryId,
        country: country ?? this.country,
        products: products ?? this.products,
        $productsCount: $productsCount ?? this.$productsCount);
  }

  BrandSeller copyWithInstance(BrandSeller brandSeller) {
    return BrandSeller(
        id: brandSeller.id ?? id,
        name: brandSeller.name ?? name,
        description: brandSeller.description ?? description,
        referenceLocation: brandSeller.referenceLocation ?? referenceLocation,
        countryId: brandSeller.countryId ?? countryId,
        country: brandSeller.country ?? country,
        products: brandSeller.products ?? products,
        $productsCount: brandSeller.$productsCount ?? $productsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (referenceLocation != null) 'referenceLocation': referenceLocation,
        if (countryId != null) 'countryId': countryId,
        if (country != null) 'country': country,
        if (products != null)
          'products': products?.map((item) => item.toJson()).toList(),
        if ($productsCount != null)
          '_count': {
            if ($productsCount != null) 'products': $productsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandSeller &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          referenceLocation == other.referenceLocation &&
          countryId == other.countryId &&
          country == other.country &&
          areListsEqual(products, other.products) &&
          $productsCount == other.$productsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      referenceLocation.hashCode ^
      countryId.hashCode ^
      country.hashCode ^
      products.hashCode ^
      $productsCount.hashCode;
}
