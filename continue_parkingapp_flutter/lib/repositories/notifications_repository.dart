import 'dart:io';
import 'dart:ui';
import 'package:continue_parkingapp_flutter/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

Future<void> requestPermissions() async {
  if (Platform.isIOS) {
    final impl = notificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await impl?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  if (Platform.isMacOS) {
    final impl = notificationsPlugin.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();
    await impl?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  if (Platform.isAndroid) {
    final impl = notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await impl?.requestNotificationsPermission();
  }
}

Future<void> scheduleNotification({
  required String title,
  required String content,
  required DateTime startTime,
  required DateTime endTime,
  required int id,
}) async {
  try {
    final duration = endTime.difference(startTime);
    final halfwayPoint = startTime.add(duration ~/ 2);
    final thirtySecondsBeforeEnd = endTime.subtract(const Duration(seconds: 30));

    // Base notification settings
    final baseNotification = NotificationDetails(
      android: AndroidNotificationDetails(
        'parking_channel',
        'Parking Notifications',
        channelDescription: 'Notifications for parking status',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    // Countdown notification settings
    final countdownNotification = NotificationDetails(
      android: AndroidNotificationDetails(
        'countdown_channel',
        'Countdown Notifications',
        channelDescription: 'Countdown for parking expiration',
        importance: Importance.high,
        priority: Priority.high,
        chronometerCountDown: true,
        usesChronometer: true,
        when: endTime.millisecondsSinceEpoch,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    // Schedule start notification
    await notificationsPlugin.zonedSchedule(
      id,
      'Parking Started',
      'Duration: ${duration.inHours}h ${duration.inMinutes % 60}m',
      tz.TZDateTime.from(startTime, tz.local),
      baseNotification,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    // Schedule halfway notification
    await notificationsPlugin.zonedSchedule(
      id + 1,
      'Halfway Point',
      'Half of your parking time has passed',
      tz.TZDateTime.from(halfwayPoint, tz.local),
      baseNotification,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    // Schedule 30-second countdown notification
    await notificationsPlugin.zonedSchedule(
      id + 2,
      '30 Seconds Remaining',
      'Your parking is ending soon!',
      tz.TZDateTime.from(thirtySecondsBeforeEnd, tz.local),
      countdownNotification,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    // Schedule end notification
    await notificationsPlugin.zonedSchedule(
      id + 3,
      'Parking Ended',
      'Your parking has ended',
      tz.TZDateTime.from(endTime, tz.local),
      baseNotification,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  } catch (e) {
    print('Error scheduling notifications: $e');
    throw Exception('Failed to schedule notifications: $e');
  }
}

