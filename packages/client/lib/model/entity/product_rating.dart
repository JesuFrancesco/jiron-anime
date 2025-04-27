//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'client.dart';
import 'product.dart';
import 'rating_attachment.dart';

class ProductRating implements ToJson, Id {
  @override
  int? id;
  int? score;
  String? text;
  DateTime? createdAt;
  Client? client;
  Product? product;
  List<RatingAttachment>? ratingAttachments;
  int? clientId;
  int? productId;
  int? $ratingAttachmentsCount;

  ProductRating({
    this.id,
    this.score,
    this.text,
    this.createdAt,
    this.client,
    this.product,
    this.ratingAttachments,
    this.clientId,
    this.productId,
    this.$ratingAttachmentsCount,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
      id: json['id'] as int?,
      score: json['score'] as int?,
      text: json['text'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      ratingAttachments: json['ratingAttachments'] != null
          ? createModels<RatingAttachment>(
              json['ratingAttachments'], RatingAttachment.fromJson)
          : null,
      clientId: json['clientId'] as int?,
      productId: json['productId'] as int?,
      $ratingAttachmentsCount: json['_count']?['ratingAttachments'] as int?);

  ProductRating copyWith({
    int? id,
    int? score,
    String? text,
    DateTime? createdAt,
    Client? client,
    Product? product,
    List<RatingAttachment>? ratingAttachments,
    int? clientId,
    int? productId,
    int? $ratingAttachmentsCount,
  }) {
    return ProductRating(
        id: id ?? this.id,
        score: score ?? this.score,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        client: client ?? this.client,
        product: product ?? this.product,
        ratingAttachments: ratingAttachments ?? this.ratingAttachments,
        clientId: clientId ?? this.clientId,
        productId: productId ?? this.productId,
        $ratingAttachmentsCount:
            $ratingAttachmentsCount ?? this.$ratingAttachmentsCount);
  }

  ProductRating copyWithInstance(ProductRating productRating) {
    return ProductRating(
        id: productRating.id ?? id,
        score: productRating.score ?? score,
        text: productRating.text ?? text,
        createdAt: productRating.createdAt ?? createdAt,
        client: productRating.client ?? client,
        product: productRating.product ?? product,
        ratingAttachments: productRating.ratingAttachments ?? ratingAttachments,
        clientId: productRating.clientId ?? clientId,
        productId: productRating.productId ?? productId,
        $ratingAttachmentsCount:
            productRating.$ratingAttachmentsCount ?? $ratingAttachmentsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (score != null) 'score': score,
        if (text != null) 'text': text,
        if (createdAt != null) 'createdAt': createdAt,
        if (client != null) 'client': client,
        if (product != null) 'product': product,
        if (ratingAttachments != null)
          'ratingAttachments':
              ratingAttachments?.map((item) => item.toJson()).toList(),
        if (clientId != null) 'clientId': clientId,
        if (productId != null) 'productId': productId,
        if ($ratingAttachmentsCount != null)
          '_count': {
            if ($ratingAttachmentsCount != null)
              'ratingAttachments': $ratingAttachmentsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductRating &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          score == other.score &&
          text == other.text &&
          createdAt == other.createdAt &&
          client == other.client &&
          product == other.product &&
          areListsEqual(ratingAttachments, other.ratingAttachments) &&
          clientId == other.clientId &&
          productId == other.productId &&
          $ratingAttachmentsCount == other.$ratingAttachmentsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      score.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      client.hashCode ^
      product.hashCode ^
      ratingAttachments.hashCode ^
      clientId.hashCode ^
      productId.hashCode ^
      $ratingAttachmentsCount.hashCode;
}
