//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'client.dart';
import 'market.dart';
import 'message.dart';

class User implements ToJson, IdString {
  @override
  String? id;
  String? email;
  String? role;
  Map<String, dynamic>? rawAppMetadata;
  Map<String, dynamic>? rawUserMetadata;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  Client? client;
  List<Market>? markets;
  List<Message>? messages;
  int? $marketsCount;
  int? $messagesCount;

  User({
    this.id,
    this.email,
    this.role,
    this.rawAppMetadata,
    this.rawUserMetadata,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.markets,
    this.messages,
    this.$marketsCount,
    this.$messagesCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      rawAppMetadata: json['rawAppMetadata'] as Map<String, dynamic>?,
      rawUserMetadata: json['rawUserMetadata'] as Map<String, dynamic>?,
      phone: json['phone'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      client: json['client'] != null
          ? Client.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      markets: json['markets'] != null
          ? createModels<Market>(json['markets'], Market.fromJson)
          : null,
      messages: json['messages'] != null
          ? createModels<Message>(json['messages'], Message.fromJson)
          : null,
      $marketsCount: json['_count']?['markets'] as int?,
      $messagesCount: json['_count']?['messages'] as int?);

  User copyWith({
    String? id,
    String? email,
    String? role,
    Map<String, dynamic>? rawAppMetadata,
    Map<String, dynamic>? rawUserMetadata,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    Client? client,
    List<Market>? markets,
    List<Message>? messages,
    int? $marketsCount,
    int? $messagesCount,
  }) {
    return User(
        id: id ?? this.id,
        email: email ?? this.email,
        role: role ?? this.role,
        rawAppMetadata: rawAppMetadata ?? this.rawAppMetadata,
        rawUserMetadata: rawUserMetadata ?? this.rawUserMetadata,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        client: client ?? this.client,
        markets: markets ?? this.markets,
        messages: messages ?? this.messages,
        $marketsCount: $marketsCount ?? this.$marketsCount,
        $messagesCount: $messagesCount ?? this.$messagesCount);
  }

  User copyWithInstance(User user) {
    return User(
        id: user.id ?? id,
        email: user.email ?? email,
        role: user.role ?? role,
        rawAppMetadata: user.rawAppMetadata ?? rawAppMetadata,
        rawUserMetadata: user.rawUserMetadata ?? rawUserMetadata,
        phone: user.phone ?? phone,
        createdAt: user.createdAt ?? createdAt,
        updatedAt: user.updatedAt ?? updatedAt,
        client: user.client ?? client,
        markets: user.markets ?? markets,
        messages: user.messages ?? messages,
        $marketsCount: user.$marketsCount ?? $marketsCount,
        $messagesCount: user.$messagesCount ?? $messagesCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (email != null) 'email': email,
        if (role != null) 'role': role,
        if (rawAppMetadata != null) 'rawAppMetadata': rawAppMetadata,
        if (rawUserMetadata != null) 'rawUserMetadata': rawUserMetadata,
        if (phone != null) 'phone': phone,
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (client != null) 'client': client,
        if (markets != null)
          'markets': markets?.map((item) => item.toJson()).toList(),
        if (messages != null)
          'messages': messages?.map((item) => item.toJson()).toList(),
        if ($marketsCount != null || $messagesCount != null)
          '_count': {
            if ($marketsCount != null) 'markets': $marketsCount,
            if ($messagesCount != null) 'messages': $messagesCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          role == other.role &&
          rawAppMetadata == other.rawAppMetadata &&
          rawUserMetadata == other.rawUserMetadata &&
          phone == other.phone &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          client == other.client &&
          areListsEqual(markets, other.markets) &&
          areListsEqual(messages, other.messages) &&
          $marketsCount == other.$marketsCount &&
          $messagesCount == other.$messagesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      role.hashCode ^
      rawAppMetadata.hashCode ^
      rawUserMetadata.hashCode ^
      phone.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      client.hashCode ^
      markets.hashCode ^
      messages.hashCode ^
      $marketsCount.hashCode ^
      $messagesCount.hashCode;
}
