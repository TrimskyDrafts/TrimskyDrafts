import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trimsky_draft/src/util/received_notification.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String navigationActionId = 'id_3';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
  StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class NotificationService {
  static int id = 0;

  static const windowsNotificationsPlatform = MethodChannel('dev.trimsky/notifications');

  static const androidDetails = AndroidNotificationDetails(
    "trimsky_notifications",
    "notification"
  );
  static const _darwinDetails = DarwinNotificationDetails();
  static const _linuxDetails = LinuxNotificationDetails();
  static const _noticeDetails = NotificationDetails(
    iOS: _darwinDetails,
    macOS: _darwinDetails,
    android: androidDetails,
    linux: _linuxDetails
  );

  static void setup() async {
    _configureLocalTimeZone();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings darwinSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _checkNotificationType
    );  
  }

  static void _checkNotificationType(NotificationResponse response) {
    switch (response.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(response.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (response.actionId == navigationActionId) {
          selectNotificationStream.add(response.payload);
        }
        break;
    }
  }

  static void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    didReceiveLocalNotificationStream.add(
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }

  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux || Platform.isWindows) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> sendNotification(String taskName) async {
    if(Platform.isWindows) {
      windowsNotificationsPlatform.invokeMethod("sendAlarmNotification", taskName);
    } else {
      flutterLocalNotificationsPlugin.show(id++, "Task \"$taskName\" was finished.", "", _noticeDetails);
    }
  }
}