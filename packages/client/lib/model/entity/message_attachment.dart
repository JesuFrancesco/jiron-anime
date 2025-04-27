//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'message.dart';

class MessageAttachment implements ToJson, Id {
  @override
  int? id;
  String? blobUrl;
  String? filename;
  String? type;
  int? messageId;
  Message? message;

  MessageAttachment({
    this.id,
    this.blobUrl,
    this.filename,
    this.type,
    this.messageId,
    this.message,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) =>
      MessageAttachment(
          id: json['id'] as int?,
          blobUrl: json['blobUrl'] as String?,
          filename: json['filename'] as String?,
          type: json['type'] as String?,
          messageId: json['messageId'] as int?,
          message: json['message'] != null
              ? Message.fromJson(json['message'] as Map<String, dynamic>)
              : null);

  MessageAttachment copyWith({
    int? id,
    String? blobUrl,
    String? filename,
    String? type,
    int? messageId,
    Message? message,
  }) {
    return MessageAttachment(
        id: id ?? this.id,
        blobUrl: blobUrl ?? this.blobUrl,
        filename: filename ?? this.filename,
        type: type ?? this.type,
        messageId: messageId ?? this.messageId,
        message: message ?? this.message);
  }

  MessageAttachment copyWithInstance(MessageAttachment messageAttachment) {
    return MessageAttachment(
        id: messageAttachment.id ?? id,
        blobUrl: messageAttachment.blobUrl ?? blobUrl,
        filename: messageAttachment.filename ?? filename,
        type: messageAttachment.type ?? type,
        messageId: messageAttachment.messageId ?? messageId,
        message: messageAttachment.message ?? message);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (id != null) 'id': id,
        if (blobUrl != null) 'blobUrl': blobUrl,
        if (filename != null) 'filename': filename,
        if (type != null) 'type': type,
        if (messageId != null) 'messageId': messageId,
        if (message != null) 'message': message
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAttachment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          blobUrl == other.blobUrl &&
          filename == other.filename &&
          type == other.type &&
          messageId == other.messageId &&
          message == other.message;

  @override
  int get hashCode =>
      id.hashCode ^
      blobUrl.hashCode ^
      filename.hashCode ^
      type.hashCode ^
      messageId.hashCode ^
      message.hashCode;
}
