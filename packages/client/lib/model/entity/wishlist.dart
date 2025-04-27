//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'client.dart';
import 'wishlist_item.dart';

class Wishlist implements ToJson, Id {
  @override
  int? id;
  int? clientId;
  Client? client;
  List<WishlistItem>? wishlistItems;
  int? $wishlistItemsCount;

  Wishlist({
    this.id,
    this.clientId,
    this.client,
    this.wishlistItems,
    this.$wishlistItemsCount,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
      id: json['id'] as int?,
      clientId: json['clientId'] as int?,
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      wishlistItems: json['wishlistItems'] != null
          ? createModels<WishlistItem>(
              json['wishlistItems'], WishlistItem.fromJson)
          : null,
      $wishlistItemsCount: json['_count']?['wishlistItems'] as int?);

  Wishlist copyWith({
    int? id,
    int? clientId,
    Client? client,
    List<WishlistItem>? wishlistItems,
    int? $wishlistItemsCount,
  }) {
    return Wishlist(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        client: client ?? this.client,
        wishlistItems: wishlistItems ?? this.wishlistItems,
        $wishlistItemsCount: $wishlistItemsCount ?? this.$wishlistItemsCount);
  }

  Wishlist copyWithInstance(Wishlist wishlist) {
    return Wishlist(
        id: wishlist.id ?? id,
        clientId: wishlist.clientId ?? clientId,
        client: wishlist.client ?? client,
        wishlistItems: wishlist.wishlistItems ?? wishlistItems,
        $wishlistItemsCount:
            wishlist.$wishlistItemsCount ?? $wishlistItemsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (clientId != null) 'clientId': clientId,
        if (client != null) 'client': client,
        if (wishlistItems != null)
          'wishlistItems': wishlistItems?.map((item) => item.toJson()).toList(),
        if ($wishlistItemsCount != null)
          '_count': {
            if ($wishlistItemsCount != null)
              'wishlistItems': $wishlistItemsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wishlist &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          clientId == other.clientId &&
          client == other.client &&
          areListsEqual(wishlistItems, other.wishlistItems) &&
          $wishlistItemsCount == other.$wishlistItemsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      clientId.hashCode ^
      client.hashCode ^
      wishlistItems.hashCode ^
      $wishlistItemsCount.hashCode;
}
