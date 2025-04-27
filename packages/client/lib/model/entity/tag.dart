//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'product_tag.dart';

class Tag implements ToJson, Id {
  @override
  int? id;
  String? name;
  List<ProductTag>? productTags;
  int? $productTagsCount;

  Tag({
    this.id,
    this.name,
    this.productTags,
    this.$productTagsCount,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int?,
      name: json['name'] as String?,
      productTags: json['productTags'] != null
          ? createModels<ProductTag>(json['productTags'], ProductTag.fromJson)
          : null,
      $productTagsCount: json['_count']?['productTags'] as int?);

  Tag copyWith({
    int? id,
    String? name,
    List<ProductTag>? productTags,
    int? $productTagsCount,
  }) {
    return Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        productTags: productTags ?? this.productTags,
        $productTagsCount: $productTagsCount ?? this.$productTagsCount);
  }

  Tag copyWithInstance(Tag tag) {
    return Tag(
        id: tag.id ?? id,
        name: tag.name ?? name,
        productTags: tag.productTags ?? productTags,
        $productTagsCount: tag.$productTagsCount ?? $productTagsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (productTags != null)
          'productTags': productTags?.map((item) => item.toJson()).toList(),
        if ($productTagsCount != null)
          '_count': {
            if ($productTagsCount != null) 'productTags': $productTagsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          areListsEqual(productTags, other.productTags) &&
          $productTagsCount == other.$productTagsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      productTags.hashCode ^
      $productTagsCount.hashCode;
}
