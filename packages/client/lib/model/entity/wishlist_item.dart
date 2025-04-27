//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'wishlist.dart';
import 'product.dart';

class WishlistItem implements ToJson {
  int? wishlistId;
  int? productId;
  DateTime? addedAt;
  Wishlist? wishlist;
  Product? product;

  WishlistItem({
    this.wishlistId,
    this.productId,
    this.addedAt,
    this.wishlist,
    this.product,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
      wishlistId: json['wishlistId'] as int?,
      productId: json['productId'] as int?,
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : null,
      wishlist: json['wishlist'] != null
          ? Wishlist.fromJson(json['wishlist'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null);

  WishlistItem copyWith({
    int? wishlistId,
    int? productId,
    DateTime? addedAt,
    Wishlist? wishlist,
    Product? product,
  }) {
    return WishlistItem(
        wishlistId: wishlistId ?? this.wishlistId,
        productId: productId ?? this.productId,
        addedAt: addedAt ?? this.addedAt,
        wishlist: wishlist ?? this.wishlist,
        product: product ?? this.product);
  }

  WishlistItem copyWithInstance(WishlistItem wishlistItem) {
    return WishlistItem(
        wishlistId: wishlistItem.wishlistId ?? wishlistId,
        productId: wishlistItem.productId ?? productId,
        addedAt: wishlistItem.addedAt ?? addedAt,
        wishlist: wishlistItem.wishlist ?? wishlist,
        product: wishlistItem.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (wishlistId != null) 'wishlistId': wishlistId,
        if (productId != null) 'productId': productId,
        if (addedAt != null) 'addedAt': addedAt,
        if (wishlist != null) 'wishlist': wishlist,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItem &&
          runtimeType == other.runtimeType &&
          wishlistId == other.wishlistId &&
          productId == other.productId &&
          addedAt == other.addedAt &&
          wishlist == other.wishlist &&
          product == other.product;

  @override
  int get hashCode =>
      wishlistId.hashCode ^
      productId.hashCode ^
      addedAt.hashCode ^
      wishlist.hashCode ^
      product.hashCode;
}
