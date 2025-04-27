//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'shopping_cart.dart';
import 'product.dart';

class CartItem implements ToJson {
  int? cartId;
  int? productId;
  int? amount;
  DateTime? addedAt;
  ShoppingCart? shoppingCart;
  Product? product;

  CartItem({
    this.cartId,
    this.productId,
    this.amount,
    this.addedAt,
    this.shoppingCart,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
      cartId: json['cartId'] as int?,
      productId: json['productId'] as int?,
      amount: json['amount'] as int?,
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : null,
      shoppingCart: json['shoppingCart'] != null
          ? ShoppingCart.fromJson(json['shoppingCart'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null);

  CartItem copyWith({
    int? cartId,
    int? productId,
    int? amount,
    DateTime? addedAt,
    ShoppingCart? shoppingCart,
    Product? product,
  }) {
    return CartItem(
        cartId: cartId ?? this.cartId,
        productId: productId ?? this.productId,
        amount: amount ?? this.amount,
        addedAt: addedAt ?? this.addedAt,
        shoppingCart: shoppingCart ?? this.shoppingCart,
        product: product ?? this.product);
  }

  CartItem copyWithInstance(CartItem cartItem) {
    return CartItem(
        cartId: cartItem.cartId ?? cartId,
        productId: cartItem.productId ?? productId,
        amount: cartItem.amount ?? amount,
        addedAt: cartItem.addedAt ?? addedAt,
        shoppingCart: cartItem.shoppingCart ?? shoppingCart,
        product: cartItem.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (cartId != null) 'cartId': cartId,
        if (productId != null) 'productId': productId,
        if (amount != null) 'amount': amount,
        if (addedAt != null) 'addedAt': addedAt,
        if (shoppingCart != null) 'shoppingCart': shoppingCart,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          cartId == other.cartId &&
          productId == other.productId &&
          amount == other.amount &&
          addedAt == other.addedAt &&
          shoppingCart == other.shoppingCart &&
          product == other.product;

  @override
  int get hashCode =>
      cartId.hashCode ^
      productId.hashCode ^
      amount.hashCode ^
      addedAt.hashCode ^
      shoppingCart.hashCode ^
      product.hashCode;
}
