//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'chat.dart';
import 'client.dart';

class ChatParticipant implements ToJson {
  int? chatId;
  int? clientId;
  Chat? chat;
  Client? client;

  ChatParticipant({
    this.chatId,
    this.clientId,
    this.chat,
    this.client,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) =>
      ChatParticipant(
          chatId: json['chatId'] as int?,
          clientId: json['clientId'] as int?,
          chat: json['chat'] != null
              ? Chat.fromJson(json['chat'] as Map<String, dynamic>)
              : null,
          client: json['client'] != null
              ? Client.fromJson(json['client'] as Map<String, dynamic>)
              : null);

  ChatParticipant copyWith({
    int? chatId,
    int? clientId,
    Chat? chat,
    Client? client,
  }) {
    return ChatParticipant(
        chatId: chatId ?? this.chatId,
        clientId: clientId ?? this.clientId,
        chat: chat ?? this.chat,
        client: client ?? this.client);
  }

  ChatParticipant copyWithInstance(ChatParticipant chatParticipant) {
    return ChatParticipant(
        chatId: chatParticipant.chatId ?? chatId,
        clientId: chatParticipant.clientId ?? clientId,
        chat: chatParticipant.chat ?? chat,
        client: chatParticipant.client ?? client);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (chatId != null) 'chatId': chatId,
        if (clientId != null) 'clientId': clientId,
        if (chat != null) 'chat': chat,
        if (client != null) 'client': client
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatParticipant &&
          runtimeType == other.runtimeType &&
          chatId == other.chatId &&
          clientId == other.clientId &&
          chat == other.chat &&
          client == other.client;

  @override
  int get hashCode =>
      chatId.hashCode ^ clientId.hashCode ^ chat.hashCode ^ client.hashCode;
}
