import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse) {}
  static Future init() async {
    InitializationSettings settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
  }

  //1.basic notification
  static showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails('id 1', 'basic notification',
            importance: Importance.max, priority: Priority.high));
    await flutterLocalNotificationsPlugin.show(
        0, 'Basic notification', 'body', details,
        payload: 'playload Data');
  }


  //Repeated Notification
    static showRepeatedNotification() async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails('id 2', 'repeated notification',
            importance: Importance.max, priority: Priority.high));
    await flutterLocalNotificationsPlugin.periodicallyShow(
        1, 'Repeated notification', 'body',RepeatInterval.everyMinute, details,
        payload: 'playload Data');
  }


  //shedule notification

   static showSheduleNotification() async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails('id 2', 'shedule notification',
            importance: Importance.max, priority: Priority.high));
    await flutterLocalNotificationsPlugin.periodicallyShow(
        1, 'Scheduled notification', 'body',RepeatInterval.everyMinute, details,
        payload: 'playload Data');
  }
 static void cancelNotification(int id )async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
//1.setup
//2.basic notification
//repeated notification
//4.sheduled notofication