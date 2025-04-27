//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'profile.dart';
import 'message_attachment.dart';
import 'chat_message.dart';

class Message implements ToJson, Id {
  @override
  int? id;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? profileId;
  Profile? profile;
  List<MessageAttachment>? messageAttachments;
  List<ChatMessage>? chatMessages;
  int? $messageAttachmentsCount;
  int? $chatMessagesCount;

  Message({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.profileId,
    this.profile,
    this.messageAttachments,
    this.chatMessages,
    this.$messageAttachmentsCount,
    this.$chatMessagesCount,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      text: json['text'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      status: json['status'] as int?,
      profileId: json['profileId'] as String?,
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
      messageAttachments: json['messageAttachments'] != null
          ? createModels<MessageAttachment>(
              json['messageAttachments'], MessageAttachment.fromJson)
          : null,
      chatMessages: json['chatMessages'] != null
          ? createModels<ChatMessage>(
              json['chatMessages'], ChatMessage.fromJson)
          : null,
      $messageAttachmentsCount: json['_count']?['messageAttachments'] as int?,
      $chatMessagesCount: json['_count']?['chatMessages'] as int?);

  Message copyWith({
    int? id,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? status,
    String? profileId,
    Profile? profile,
    List<MessageAttachment>? messageAttachments,
    List<ChatMessage>? chatMessages,
    int? $messageAttachmentsCount,
    int? $chatMessagesCount,
  }) {
    return Message(
        id: id ?? this.id,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        profileId: profileId ?? this.profileId,
        profile: profile ?? this.profile,
        messageAttachments: messageAttachments ?? this.messageAttachments,
        chatMessages: chatMessages ?? this.chatMessages,
        $messageAttachmentsCount:
            $messageAttachmentsCount ?? this.$messageAttachmentsCount,
        $chatMessagesCount: $chatMessagesCount ?? this.$chatMessagesCount);
  }

  Message copyWithInstance(Message message) {
    return Message(
        id: message.id ?? id,
        text: message.text ?? text,
        createdAt: message.createdAt ?? createdAt,
        updatedAt: message.updatedAt ?? updatedAt,
        status: message.status ?? status,
        profileId: message.profileId ?? profileId,
        profile: message.profile ?? profile,
        messageAttachments: message.messageAttachments ?? messageAttachments,
        chatMessages: message.chatMessages ?? chatMessages,
        $messageAttachmentsCount:
            message.$messageAttachmentsCount ?? $messageAttachmentsCount,
        $chatMessagesCount: message.$chatMessagesCount ?? $chatMessagesCount);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (text != null) 'text': text,
        if (createdAt != null) 'createdAt': createdAt,
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (status != null) 'status': status,
        if (profileId != null) 'profileId': profileId,
        if (profile != null) 'profile': profile,
        if (messageAttachments != null)
          'messageAttachments':
              messageAttachments?.map((item) => item.toJson()).toList(),
        if (chatMessages != null)
          'chatMessages': chatMessages?.map((item) => item.toJson()).toList(),
        if ($messageAttachmentsCount != null || $chatMessagesCount != null)
          '_count': {
            if ($messageAttachmentsCount != null)
              'messageAttachments': $messageAttachmentsCount,
            if ($chatMessagesCount != null) 'chatMessages': $chatMessagesCount,
          },
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          status == other.status &&
          profileId == other.profileId &&
          profile == other.profile &&
          areListsEqual(messageAttachments, other.messageAttachments) &&
          areListsEqual(chatMessages, other.chatMessages) &&
          $messageAttachmentsCount == other.$messageAttachmentsCount &&
          $chatMessagesCount == other.$chatMessagesCount;

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      status.hashCode ^
      profileId.hashCode ^
      profile.hashCode ^
      messageAttachments.hashCode ^
      chatMessages.hashCode ^
      $messageAttachmentsCount.hashCode ^
      $chatMessagesCount.hashCode;
}
