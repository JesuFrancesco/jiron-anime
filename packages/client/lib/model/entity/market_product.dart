//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'market.dart';
import 'product.dart';

class MarketProduct implements ToJson {
  int? marketId;
  int? productId;
  Market? market;
  Product? product;

  MarketProduct({
    this.marketId,
    this.productId,
    this.market,
    this.product,
  });

  factory MarketProduct.fromJson(Map<String, dynamic> json) => MarketProduct(
      marketId: json['marketId'] as int?,
      productId: json['productId'] as int?,
      market: json['market'] != null
          ? Market.fromJson(json['market'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null);

  MarketProduct copyWith({
    int? marketId,
    int? productId,
    Market? market,
    Product? product,
  }) {
    return MarketProduct(
        marketId: marketId ?? this.marketId,
        productId: productId ?? this.productId,
        market: market ?? this.market,
        product: product ?? this.product);
  }

  MarketProduct copyWithInstance(MarketProduct marketProduct) {
    return MarketProduct(
        marketId: marketProduct.marketId ?? marketId,
        productId: marketProduct.productId ?? productId,
        market: marketProduct.market ?? market,
        product: marketProduct.product ?? product);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (marketId != null) 'marketId': marketId,
        if (productId != null) 'productId': productId,
        if (market != null) 'market': market,
        if (product != null) 'product': product
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketProduct &&
          runtimeType == other.runtimeType &&
          marketId == other.marketId &&
          productId == other.productId &&
          market == other.market &&
          product == other.product;

  @override
  int get hashCode =>
      marketId.hashCode ^
      productId.hashCode ^
      market.hashCode ^
      product.hashCode;
}
