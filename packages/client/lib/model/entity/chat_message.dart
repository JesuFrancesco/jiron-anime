//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'chat.dart';
import 'message.dart';

class ChatMessage implements ToJson {
  int? chatId;
  int? messageId;
  Chat? chat;
  Message? message;

  ChatMessage({
    this.chatId,
    this.messageId,
    this.chat,
    this.message,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
      chatId: json['chatId'] as int?,
      messageId: json['messageId'] as int?,
      chat: json['chat'] != null
          ? Chat.fromJson(json['chat'] as Map<String, dynamic>)
          : null,
      message: json['message'] != null
          ? Message.fromJson(json['message'] as Map<String, dynamic>)
          : null);

  ChatMessage copyWith({
    int? chatId,
    int? messageId,
    Chat? chat,
    Message? message,
  }) {
    return ChatMessage(
        chatId: chatId ?? this.chatId,
        messageId: messageId ?? this.messageId,
        chat: chat ?? this.chat,
        message: message ?? this.message);
  }

  ChatMessage copyWithInstance(ChatMessage chatMessage) {
    return ChatMessage(
        chatId: chatMessage.chatId ?? chatId,
        messageId: chatMessage.messageId ?? messageId,
        chat: chatMessage.chat ?? chat,
        message: chatMessage.message ?? message);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (chatId != null) 'chatId': chatId,
        if (messageId != null) 'messageId': messageId,
        if (chat != null) 'chat': chat,
        if (message != null) 'message': message
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessage &&
          runtimeType == other.runtimeType &&
          chatId == other.chatId &&
          messageId == other.messageId &&
          chat == other.chat &&
          message == other.message;

  @override
  int get hashCode =>
      chatId.hashCode ^ messageId.hashCode ^ chat.hashCode ^ message.hashCode;
}
