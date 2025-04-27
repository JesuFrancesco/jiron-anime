//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'product.dart';

class ProductAttachment implements ToJson {
  String? imageUrl;
  int? productId;
  Product? product;

  ProductAttachment({
    this.imageUrl,
    this.productId,
    this.product,
  });

  factory ProductAttachment.fromJson(Map<String, dynamic> json) =>
      ProductAttachment(
          imageUrl: json['imageUrl'] as String?,
          productId: json['productId'] as int?,
          product: json['product'] != null
              ? Product.fromJson(json['product'] as Map<String, dynamic>)
              : null);

  ProductAttachment copyWith({
    String? imageUrl,
    int? productId,
    Product? product,
  }) {
    return ProductAttachment(
        imageUrl: imageUrl ?? this.imageUrl,
        productId: productId ?? this.productId,
        product: product ?? this.product);
  }

  ProductAttachment copyWithInstance(ProductAttachment productAttachment) {
    return ProductAttachment(
        imageUrl: productAttachment.imageUrl ?? imageUrl,
        productId: productAttachment.productId ?? productId,
        product: productAttachment.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (productId != null) 'productId': productId,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAttachment &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl &&
          productId == other.productId &&
          product == other.product;

  @override
  int get hashCode => imageUrl.hashCode ^ productId.hashCode ^ product.hashCode;
}
