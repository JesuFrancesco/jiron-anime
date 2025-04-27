//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import 'model_base.dart';
import 'user.dart';
import 'notification.dart';

class UserNotification implements ToJson {
  int? userId;
  int? notificationId;
  User? user;
  Notification? notification;

  UserNotification({
    this.userId,
    this.notificationId,
    this.user,
    this.notification,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
          userId: json['userId'] as int?,
          notificationId: json['notificationId'] as int?,
          user: json['user'] != null
              ? User.fromJson(json['user'] as Map<String, dynamic>)
              : null,
          notification:
              json['notification'] != null
                  ? Notification.fromJson(
                      json['notification'] as Map<String, dynamic>)
                  : null);

  UserNotification copyWith({
    int? userId,
    int? notificationId,
    User? user,
    Notification? notification,
  }) {
    return UserNotification(
        userId: userId ?? this.userId,
        notificationId: notificationId ?? this.notificationId,
        user: user ?? this.user,
        notification: notification ?? this.notification);
  }

  UserNotification copyWithInstance(UserNotification userNotification) {
    return UserNotification(
        userId: userNotification.userId ?? userId,
        notificationId: userNotification.notificationId ?? notificationId,
        user: userNotification.user ?? user,
        notification: userNotification.notification ?? notification);
  }

  @override
  Map<String, dynamic> toJson() => ({
        if (userId != null) 'userId': userId,
        if (notificationId != null) 'notificationId': notificationId,
        if (user != null) 'user': user,
        if (notification != null) 'notification': notification
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotification &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          notificationId == other.notificationId &&
          user == other.user &&
          notification == other.notification;

  @override
  int get hashCode =>
      userId.hashCode ^
      notificationId.hashCode ^
      user.hashCode ^
      notification.hashCode;
}
