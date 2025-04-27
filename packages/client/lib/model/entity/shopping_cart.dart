//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'client.dart';
import 'cart_item.dart';

class ShoppingCart implements ToJson, Id {
  @override
  int? id;
  int? clientId;
  Client? client;
  List<CartItem>? cartItems;
  int? $cartItemsCount;

  ShoppingCart({
    this.id,
    this.clientId,
    this.client,
    this.cartItems,
    this.$cartItemsCount,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
      id: json['id'] as int?,
      clientId: json['clientId'] as int?,
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      cartItems: json['cartItems'] != null
          ? createModels<CartItem>(json['cartItems'], CartItem.fromJson)
          : null,
      $cartItemsCount: json['_count']?['cartItems'] as int?);

  ShoppingCart copyWith({
    int? id,
    int? clientId,
    Client? client,
    List<CartItem>? cartItems,
    int? $cartItemsCount,
  }) {
    return ShoppingCart(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        client: client ?? this.client,
        cartItems: cartItems ?? this.cartItems,
        $cartItemsCount: $cartItemsCount ?? this.$cartItemsCount);
  }

  ShoppingCart copyWithInstance(ShoppingCart shoppingCart) {
    return ShoppingCart(
        id: shoppingCart.id ?? id,
        clientId: shoppingCart.clientId ?? clientId,
        client: shoppingCart.client ?? client,
        cartItems: shoppingCart.cartItems ?? cartItems,
        $cartItemsCount: shoppingCart.$cartItemsCount ?? $cartItemsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (clientId != null) 'clientId': clientId,
        if (client != null) 'client': client,
        if (cartItems != null)
          'cartItems': cartItems?.map((item) => item.toJson()).toList(),
        if ($cartItemsCount != null)
          '_count': {
            if ($cartItemsCount != null) 'cartItems': $cartItemsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingCart &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          clientId == other.clientId &&
          client == other.client &&
          areListsEqual(cartItems, other.cartItems) &&
          $cartItemsCount == other.$cartItemsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      clientId.hashCode ^
      client.hashCode ^
      cartItems.hashCode ^
      $cartItemsCount.hashCode;
}
