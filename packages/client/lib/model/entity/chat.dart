//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'chat_message.dart';
import 'chat_participant.dart';

class Chat implements ToJson, Id {
  @override
  int? id;
  DateTime? createdAt;
  List<ChatMessage>? chatMessage;
  List<ChatParticipant>? chatParticipants;
  int? $chatMessageCount;
  int? $chatParticipantsCount;

  Chat({
    this.id,
    this.createdAt,
    this.chatMessage,
    this.chatParticipants,
    this.$chatMessageCount,
    this.$chatParticipantsCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as int?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      chatMessage: json['chatMessage'] != null
          ? createModels<ChatMessage>(json['chatMessage'], ChatMessage.fromJson)
          : null,
      chatParticipants: json['chatParticipants'] != null
          ? createModels<ChatParticipant>(
              json['chatParticipants'], ChatParticipant.fromJson)
          : null,
      $chatMessageCount: json['_count']?['chatMessage'] as int?,
      $chatParticipantsCount: json['_count']?['chatParticipants'] as int?);

  Chat copyWith({
    int? id,
    DateTime? createdAt,
    List<ChatMessage>? chatMessage,
    List<ChatParticipant>? chatParticipants,
    int? $chatMessageCount,
    int? $chatParticipantsCount,
  }) {
    return Chat(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        chatMessage: chatMessage ?? this.chatMessage,
        chatParticipants: chatParticipants ?? this.chatParticipants,
        $chatMessageCount: $chatMessageCount ?? this.$chatMessageCount,
        $chatParticipantsCount:
            $chatParticipantsCount ?? this.$chatParticipantsCount);
  }

  Chat copyWithInstance(Chat chat) {
    return Chat(
        id: chat.id ?? id,
        createdAt: chat.createdAt ?? createdAt,
        chatMessage: chat.chatMessage ?? chatMessage,
        chatParticipants: chat.chatParticipants ?? chatParticipants,
        $chatMessageCount: chat.$chatMessageCount ?? $chatMessageCount,
        $chatParticipantsCount:
            chat.$chatParticipantsCount ?? $chatParticipantsCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (createdAt != null) 'createdAt': createdAt,
        if (chatMessage != null)
          'chatMessage': chatMessage?.map((item) => item.toJson()).toList(),
        if (chatParticipants != null)
          'chatParticipants':
              chatParticipants?.map((item) => item.toJson()).toList(),
        if ($chatMessageCount != null || $chatParticipantsCount != null)
          '_count': {
            if ($chatMessageCount != null) 'chatMessage': $chatMessageCount,
            if ($chatParticipantsCount != null)
              'chatParticipants': $chatParticipantsCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          areListsEqual(chatMessage, other.chatMessage) &&
          areListsEqual(chatParticipants, other.chatParticipants) &&
          $chatMessageCount == other.$chatMessageCount &&
          $chatParticipantsCount == other.$chatParticipantsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      chatMessage.hashCode ^
      chatParticipants.hashCode ^
      $chatMessageCount.hashCode ^
      $chatParticipantsCount.hashCode;
}
