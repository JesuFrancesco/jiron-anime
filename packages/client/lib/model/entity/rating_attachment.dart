//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'product_rating.dart';

class RatingAttachment implements ToJson {
  int? ratingId;
  String? imageUrl;
  ProductRating? productRating;

  RatingAttachment({
    this.ratingId,
    this.imageUrl,
    this.productRating,
  });

  factory RatingAttachment.fromJson(Map<String, dynamic> json) =>
      RatingAttachment(
          ratingId: json['ratingId'] as int?,
          imageUrl: json['imageUrl'] as String?,
          productRating: json['productRating'] != null
              ? ProductRating.fromJson(
                  json['productRating'] as Map<String, dynamic>)
              : null);

  RatingAttachment copyWith({
    int? ratingId,
    String? imageUrl,
    ProductRating? productRating,
  }) {
    return RatingAttachment(
        ratingId: ratingId ?? this.ratingId,
        imageUrl: imageUrl ?? this.imageUrl,
        productRating: productRating ?? this.productRating);
  }

  RatingAttachment copyWithInstance(RatingAttachment ratingAttachment) {
    return RatingAttachment(
        ratingId: ratingAttachment.ratingId ?? ratingId,
        imageUrl: ratingAttachment.imageUrl ?? imageUrl,
        productRating: ratingAttachment.productRating ?? productRating);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (ratingId != null) 'ratingId': ratingId,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (productRating != null) 'productRating': productRating
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingAttachment &&
          runtimeType == other.runtimeType &&
          ratingId == other.ratingId &&
          imageUrl == other.imageUrl &&
          productRating == other.productRating;

  @override
  int get hashCode =>
      ratingId.hashCode ^ imageUrl.hashCode ^ productRating.hashCode;
}
