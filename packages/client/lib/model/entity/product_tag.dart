//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'tag.dart';
import 'product.dart';

class ProductTag implements ToJson {
  int? categoryId;
  int? productId;
  Tag? tag;
  Product? product;

  ProductTag({
    this.categoryId,
    this.productId,
    this.tag,
    this.product,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) => ProductTag(
      categoryId: json['categoryId'] as int?,
      productId: json['productId'] as int?,
      tag: json['tag'] != null
          ? Tag.fromJson(json['tag'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null);

  ProductTag copyWith({
    int? categoryId,
    int? productId,
    Tag? tag,
    Product? product,
  }) {
    return ProductTag(
        categoryId: categoryId ?? this.categoryId,
        productId: productId ?? this.productId,
        tag: tag ?? this.tag,
        product: product ?? this.product);
  }

  ProductTag copyWithInstance(ProductTag productTag) {
    return ProductTag(
        categoryId: productTag.categoryId ?? categoryId,
        productId: productTag.productId ?? productId,
        tag: productTag.tag ?? tag,
        product: productTag.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (categoryId != null) 'categoryId': categoryId,
        if (productId != null) 'productId': productId,
        if (tag != null) 'tag': tag,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTag &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          productId == other.productId &&
          tag == other.tag &&
          product == other.product;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      productId.hashCode ^
      tag.hashCode ^
      product.hashCode;
}
