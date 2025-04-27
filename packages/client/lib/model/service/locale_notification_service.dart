import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jiron_anime/main.dart';

class LocaleNotificationService {
  static final LocaleNotificationService _notificationService =
      LocaleNotificationService._internal();

  factory LocaleNotificationService() {
    return _notificationService;
  }

  LocaleNotificationService._internal();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: selectNotification,
        onDidReceiveNotificationResponse: selectNotification);
  }

  static Future selectNotification(NotificationResponse payload) async {
    await File(payload.payload!).open();
  }
}
