// ignore_for_file: non_constant_identifier_names

import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // ignore: avoid_types_as_parameter_names
  static onTap(NotificationResponse) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
  }

  static Future<void> showDailyScheduledNotification(
      {TimeOfDay? time, required String question}) async {
    if (time != null) {
      tz.initializeTimeZones();
      tz.setLocalLocation(
          tz.getLocation('Asia/Kolkata')); // Set your desired time zone
      final now = DateTime.now();
      final scheduledDateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        'TickyFy',
        //intializing as mt
        '',
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'id4',
            'Daily Scheduled Notification',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_notification',
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
      );
      //unotification as habit question
      habbitNotifierList.addListener(() {
        final habbitQuestion =
          question;
        flutterLocalNotificationsPlugin.zonedSchedule(
          3,
          'TickFy',
          habbitQuestion,
          tz.TZDateTime.from(scheduledDateTime, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'id4',
              'Daily Scheduled Notification',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: 'daily_notification',
        );
      });
    }
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
