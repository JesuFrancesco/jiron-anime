//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'profile.dart';
import 'product.dart';

class Market implements ToJson, Id {
  @override
  int? id;
  String? name;
  String? logoUrl;
  String? contactEmail;
  String? contactPhone;
  String? profileId;
  Profile? profile;
  List<Product>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? $productsCount;

  Market({
    this.id,
    this.name,
    this.logoUrl,
    this.contactEmail,
    this.contactPhone,
    this.profileId,
    this.profile,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.$productsCount,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
      id: json['id'] as int?,
      name: json['name'] as String?,
      logoUrl: json['logoUrl'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      profileId: json['profileId'] as String?,
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
      products: json['products'] != null
          ? createModels<Product>(json['products'], Product.fromJson)
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      $productsCount: json['_count']?['products'] as int?);

  Market copyWith({
    int? id,
    String? name,
    String? logoUrl,
    String? contactEmail,
    String? contactPhone,
    String? profileId,
    Profile? profile,
    List<Product>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? $productsCount,
  }) {
    return Market(
        id: id ?? this.id,
        name: name ?? this.name,
        logoUrl: logoUrl ?? this.logoUrl,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        profileId: profileId ?? this.profileId,
        profile: profile ?? this.profile,
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        $productsCount: $productsCount ?? this.$productsCount);
  }

  Market copyWithInstance(Market market) {
    return Market(
        id: market.id ?? id,
        name: market.name ?? name,
        logoUrl: market.logoUrl ?? logoUrl,
        contactEmail: market.contactEmail ?? contactEmail,
        contactPhone: market.contactPhone ?? contactPhone,
        profileId: market.profileId ?? profileId,
        profile: market.profile ?? profile,
        products: market.products ?? products,
        createdAt: market.createdAt ?? createdAt,
        updatedAt: market.updatedAt ?? updatedAt,
        $productsCount: market.$productsCount ?? $productsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (logoUrl != null) 'logoUrl': logoUrl,
        if (contactEmail != null) 'contactEmail': contactEmail,
        if (contactPhone != null) 'contactPhone': contactPhone,
        if (profileId != null) 'profileId': profileId,
        if (profile != null) 'profile': profile,
        if (products != null)
          'products': products?.map((item) => item.toJson()).toList(),
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if ($productsCount != null)
          '_count': {
            if ($productsCount != null) 'products': $productsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Market &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          logoUrl == other.logoUrl &&
          contactEmail == other.contactEmail &&
          contactPhone == other.contactPhone &&
          profileId == other.profileId &&
          profile == other.profile &&
          areListsEqual(products, other.products) &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          $productsCount == other.$productsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      logoUrl.hashCode ^
      contactEmail.hashCode ^
      contactPhone.hashCode ^
      profileId.hashCode ^
      profile.hashCode ^
      products.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      $productsCount.hashCode;
}
