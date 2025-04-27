//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'user.dart';
import 'market.dart';
import 'message.dart';

class Account implements ToJson, Id {
  @override
  int? id;
  String? email;
  String? role;
  String? password;
  String? phone;
  String? name;
  User? user;
  List<Market>? markets;
  List<Message>? messages;
  int? $marketsCount;
  int? $messagesCount;

  Account({
    this.id,
    this.email,
    this.role = "user",
    this.password,
    this.phone,
    this.name,
    this.user,
    this.markets,
    this.messages,
    this.$marketsCount,
    this.$messagesCount,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      markets: json['markets'] != null
          ? createModels<Market>(json['markets'], Market.fromJson)
          : null,
      messages: json['messages'] != null
          ? createModels<Message>(json['messages'], Message.fromJson)
          : null,
      $marketsCount: json['_count']?['markets'] as int?,
      $messagesCount: json['_count']?['messages'] as int?);

  Account copyWith({
    int? id,
    String? email,
    String? role,
    String? password,
    String? phone,
    String? name,
    User? user,
    List<Market>? markets,
    List<Message>? messages,
    int? $marketsCount,
    int? $messagesCount,
  }) {
    return Account(
        id: id ?? this.id,
        email: email ?? this.email,
        role: role ?? this.role,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        user: user ?? this.user,
        markets: markets ?? this.markets,
        messages: messages ?? this.messages,
        $marketsCount: $marketsCount ?? this.$marketsCount,
        $messagesCount: $messagesCount ?? this.$messagesCount);
  }

  Account copyWithInstance(Account account) {
    return Account(
        id: account.id ?? id,
        email: account.email ?? email,
        role: account.role ?? role,
        password: account.password ?? password,
        phone: account.phone ?? phone,
        name: account.name ?? name,
        user: account.user ?? user,
        markets: account.markets ?? markets,
        messages: account.messages ?? messages,
        $marketsCount: account.$marketsCount ?? $marketsCount,
        $messagesCount: account.$messagesCount ?? $messagesCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (email != null) 'email': email,
        if (role != null) 'role': role,
        if (password != null) 'password': password,
        if (phone != null) 'phone': phone,
        if (name != null) 'name': name,
        if (user != null) 'user': user,
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
      other is Account &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          role == other.role &&
          password == other.password &&
          phone == other.phone &&
          name == other.name &&
          user == other.user &&
          areListsEqual(markets, other.markets) &&
          areListsEqual(messages, other.messages) &&
          $marketsCount == other.$marketsCount &&
          $messagesCount == other.$messagesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      role.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      name.hashCode ^
      user.hashCode ^
      markets.hashCode ^
      messages.hashCode ^
      $marketsCount.hashCode ^
      $messagesCount.hashCode;
}
