import 'dart:math';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
  }

  static Future<void> showDailyScheduledNotification({TimeOfDay? time, required String question}) async {
    if (time!= null) {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // Set your desired time zone
      final now = DateTime.now();
      final scheduledDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        'TickyFy',
        'Did you do your habit',
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'id4',
            'Daily Scheduled Notification',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_notification',
      );
    }
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
