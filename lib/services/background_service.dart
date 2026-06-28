// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';
//
// import '../model/model.dart';
// import 'api.dart';
// import 'notification_tap_background.dart';
//
// // ---------------------------------------------------------------------------
// // 1. NOTIFICATION HELPER (Background / Workmanager)
// // ---------------------------------------------------------------------------
//
// /// JSON payload must match [NotificationController] tap handling (`id` / `event_id`).
// String _disasterEventPayload(DisasterEvent e) {
//   final map = <String, dynamic>{
//     'id': e.id,
//     'title': e.title,
//     'description': e.description,
//     'lat': e.latitude.toString(),
//     'lng': e.longitude.toString(),
//     'alertlevel': e.alertLevel,
//     'eventtype': e.eventType,
//     'type': 'disaster',
//   };
//   if (e.date != null) {
//     map['pubDate'] = e.date!.toIso8601String();
//   }
//   return jsonEncode(map);
// }
//
// Future<void> _showNotification(
//   String title,
//   String body,
//   DisasterEvent event,
// ) async {
//   final FlutterLocalNotificationsPlugin plugin =
//       FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings androidInit =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   const InitializationSettings initSettings =
//       InitializationSettings(android: androidInit);
//
//   await plugin.initialize(
//     settings: initSettings,
//     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//   );
//
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.max,
//     priority: Priority.high,
//     icon: '@mipmap/ic_launcher',
//     color: Color(0xFF0021C0),
//     colorized: true,
//     playSound: true,
//   );
//
//   const NotificationDetails details =
//       NotificationDetails(android: androidDetails);
//
//   await plugin.show(
//     id: DateTime.now().millisecond,
//     title: title,
//     body: body,
//     notificationDetails: details,
//     payload: _disasterEventPayload(event),
//   );
// }
//
// // ---------------------------------------------------------------------------
// // 2. BACKGROUND TASK
// // ---------------------------------------------------------------------------
//
// /// Call from app to test disaster notification (with country) without waiting 15 min.
// /// Does not change last_event_id.
// Future<void> runDisasterCheckForTest() async {
//   try {
//     final results = await Future.wait([
//       GdacsService.fetch(),
//       UsgsService.fetch(),
//       NasaService.fetch(),
//       NoaaService.fetch(),
//     ]);
//     final List<DisasterEvent> allEvents = [
//       ...results[0],
//       ...results[1],
//       ...results[2],
//       ...results[3],
//     ];
//     if (allEvents.isNotEmpty) {
//       final latestEvent = allEvents.first;
//       final countryName = latestEvent.countryOrRegionLabel;
//       await _showNotification(
//         "🚨 New ${latestEvent.eventType} Alert – $countryName",
//         latestEvent.title,
//         latestEvent,
//       );
//     }
//   } catch (e) {
//     print("❌ Test disaster check error: $e");
//   }
// }
//
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       final results = await Future.wait([
//         GdacsService.fetch(),
//         UsgsService.fetch(),
//         NasaService.fetch(),
//         NoaaService.fetch(),
//       ]);
//
//       final List<DisasterEvent> allEvents = [
//         ...results[0],
//         ...results[1],
//         ...results[2],
//         ...results[3],
//       ];
//
//       if (allEvents.isNotEmpty) {
//         final prefs = await SharedPreferences.getInstance();
//
//         final String lastEventId = prefs.getString('last_event_id') ?? "";
//
//         final latestEvent = allEvents.first;
//
//         if (latestEvent.id != lastEventId) {
//           final notificationsEnabled =
//               prefs.getBool('profile_notifications_enabled') ?? true;
//           if (!notificationsEnabled) {
//             await prefs.setString('last_event_id', latestEvent.id);
//             return Future.value(true);
//           }
//
//           final countryName = latestEvent.countryOrRegionLabel;
//           await _showNotification(
//             "🚨 New ${latestEvent.eventType} Alert – $countryName",
//             latestEvent.title,
//             latestEvent,
//           );
//
//           await prefs.setString('last_event_id', latestEvent.id);
//           print("🔔 New Notification Sent for ID: ${latestEvent.id}");
//         } else {
//           print("😴 No new disaster found. skipping notification.");
//         }
//       }
//     } catch (e) {
//       print("❌ Background Error: $e");
//     }
//     return Future.value(true);
//   });
// }
