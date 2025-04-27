//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'order.dart';
import 'product.dart';

class OrderItem implements ToJson {
  int? amount;
  int? orderId;
  int? productId;
  Order? order;
  Product? product;

  OrderItem({
    this.amount,
    this.orderId,
    this.productId,
    this.order,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      amount: json['amount'] as int?,
      orderId: json['orderId'] as int?,
      productId: json['productId'] as int?,
      order: json['order'] != null
          ? Order.fromJson(json['order'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null);

  OrderItem copyWith({
    int? amount,
    int? orderId,
    int? productId,
    Order? order,
    Product? product,
  }) {
    return OrderItem(
        amount: amount ?? this.amount,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        order: order ?? this.order,
        product: product ?? this.product);
  }

  OrderItem copyWithInstance(OrderItem orderItem) {
    return OrderItem(
        amount: orderItem.amount ?? amount,
        orderId: orderItem.orderId ?? orderId,
        productId: orderItem.productId ?? productId,
        order: orderItem.order ?? order,
        product: orderItem.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (amount != null) 'amount': amount,
        if (orderId != null) 'orderId': orderId,
        if (productId != null) 'productId': productId,
        if (order != null) 'order': order,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          orderId == other.orderId &&
          productId == other.productId &&
          order == other.order &&
          product == other.product;

  @override
  int get hashCode =>
      amount.hashCode ^
      orderId.hashCode ^
      productId.hashCode ^
      order.hashCode ^
      product.hashCode;
}
