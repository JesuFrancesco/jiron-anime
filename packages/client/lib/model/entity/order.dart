//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'package:jiron_anime/utils/double_parse.dart';

import 'model_base.dart';
import 'client.dart';
import 'order_item.dart';

class Order implements ToJson, Id {
  @override
  int? id;
  double? totalPrice;
  String? status;
  int? clientId;
  Client? client;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderItem>? orderItems;
  int? $orderItemsCount;

  Order({
    this.id,
    this.totalPrice,
    this.status,
    this.clientId,
    this.client,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
    this.$orderItemsCount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      totalPrice: parseToDouble(json['totalPrice']),
      status: json['status'] as String?,
      clientId: json['clientId'] as int?,
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      orderItems: json['orderItems'] != null
          ? createModels<OrderItem>(json['orderItems'], OrderItem.fromJson)
          : null,
      $orderItemsCount: json['_count']?['orderItems'] as int?);

  Order copyWith({
    int? id,
    double? totalPrice,
    String? status,
    int? clientId,
    Client? client,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItem>? orderItems,
    int? $orderItemsCount,
  }) {
    return Order(
        id: id ?? this.id,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        clientId: clientId ?? this.clientId,
        client: client ?? this.client,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        orderItems: orderItems ?? this.orderItems,
        $orderItemsCount: $orderItemsCount ?? this.$orderItemsCount);
  }

  Order copyWithInstance(Order order) {
    return Order(
        id: order.id ?? id,
        totalPrice: order.totalPrice ?? totalPrice,
        status: order.status ?? status,
        clientId: order.clientId ?? clientId,
        client: order.client ?? client,
        createdAt: order.createdAt ?? createdAt,
        updatedAt: order.updatedAt ?? updatedAt,
        orderItems: order.orderItems ?? orderItems,
        $orderItemsCount: order.$orderItemsCount ?? $orderItemsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (totalPrice != null) 'totalPrice': totalPrice,
        if (status != null) 'status': status,
        if (clientId != null) 'clientId': clientId,
        if (client != null) 'client': client,
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (orderItems != null)
          'orderItems': orderItems?.map((item) => item.toJson()).toList(),
        if ($orderItemsCount != null)
          '_count': {
            if ($orderItemsCount != null) 'orderItems': $orderItemsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          totalPrice == other.totalPrice &&
          status == other.status &&
          clientId == other.clientId &&
          client == other.client &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          areListsEqual(orderItems, other.orderItems) &&
          $orderItemsCount == other.$orderItemsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      totalPrice.hashCode ^
      status.hashCode ^
      clientId.hashCode ^
      client.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      orderItems.hashCode ^
      $orderItemsCount.hashCode;
}
