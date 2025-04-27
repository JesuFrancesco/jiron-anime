//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'product.dart';
import 'client.dart';
import 'question_reply.dart';

class ProductQuestion implements ToJson, Id {
  @override
  int? id;
  String? subject;
  String? text;
  int? productId;
  int? clientId;
  Product? product;
  Client? client;
  List<QuestionReply>? questionReplies;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? $questionRepliesCount;

  ProductQuestion({
    this.id,
    this.subject = "Consulta",
    this.text,
    this.productId,
    this.clientId,
    this.product,
    this.client,
    this.questionReplies,
    this.createdAt,
    this.updatedAt,
    this.$questionRepliesCount,
  });

  factory ProductQuestion.fromJson(Map<String, dynamic> json) =>
      ProductQuestion(
          id: json['id'] as int?,
          subject: json['subject'] as String?,
          text: json['text'] as String?,
          productId: json['productId'] as int?,
          clientId: json['clientId'] as int?,
          product: json['product'] != null
              ? Product.fromJson(json['product'] as Map<String, dynamic>)
              : null,
          client: json['client'] != null
              ? Client.fromJson(json['client'] as Map<String, dynamic>)
              : null,
          questionReplies: json['questionReplies'] != null
              ? createModels<QuestionReply>(
                  json['questionReplies'], QuestionReply.fromJson)
              : null,
          createdAt: json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : null,
          updatedAt: json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'])
              : null,
          $questionRepliesCount: json['_count']?['questionReplies'] as int?);

  ProductQuestion copyWith({
    int? id,
    String? subject,
    String? text,
    int? productId,
    int? clientId,
    Product? product,
    Client? client,
    List<QuestionReply>? questionReplies,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? $questionRepliesCount,
  }) {
    return ProductQuestion(
        id: id ?? this.id,
        subject: subject ?? this.subject,
        text: text ?? this.text,
        productId: productId ?? this.productId,
        clientId: clientId ?? this.clientId,
        product: product ?? this.product,
        client: client ?? this.client,
        questionReplies: questionReplies ?? this.questionReplies,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        $questionRepliesCount:
            $questionRepliesCount ?? this.$questionRepliesCount);
  }

  ProductQuestion copyWithInstance(ProductQuestion productQuestion) {
    return ProductQuestion(
        id: productQuestion.id ?? id,
        subject: productQuestion.subject ?? subject,
        text: productQuestion.text ?? text,
        productId: productQuestion.productId ?? productId,
        clientId: productQuestion.clientId ?? clientId,
        product: productQuestion.product ?? product,
        client: productQuestion.client ?? client,
        questionReplies: productQuestion.questionReplies ?? questionReplies,
        createdAt: productQuestion.createdAt ?? createdAt,
        updatedAt: productQuestion.updatedAt ?? updatedAt,
        $questionRepliesCount:
            productQuestion.$questionRepliesCount ?? $questionRepliesCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (subject != null) 'subject': subject,
        if (text != null) 'text': text,
        if (productId != null) 'productId': productId,
        if (clientId != null) 'clientId': clientId,
        if (product != null) 'product': product,
        if (client != null) 'client': client,
        if (questionReplies != null)
          'questionReplies':
              questionReplies?.map((item) => item.toJson()).toList(),
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if ($questionRepliesCount != null)
          '_count': {
            if ($questionRepliesCount != null)
              'questionReplies': $questionRepliesCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductQuestion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subject == other.subject &&
          text == other.text &&
          productId == other.productId &&
          clientId == other.clientId &&
          product == other.product &&
          client == other.client &&
          areListsEqual(questionReplies, other.questionReplies) &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          $questionRepliesCount == other.$questionRepliesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      subject.hashCode ^
      text.hashCode ^
      productId.hashCode ^
      clientId.hashCode ^
      product.hashCode ^
      client.hashCode ^
      questionReplies.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      $questionRepliesCount.hashCode;
}
