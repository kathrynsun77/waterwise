import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationHandler {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notifications if needed
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Configure Firebase messaging
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get the FCM token and send it to the Laravel endpoint
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      await sendTokenAndNotificationToEndpoint(fcmToken,"test","test");
    }
  }

  Future<void> sendTokenAndNotificationToEndpoint(String token, String title, String body) async {
    // Replace 'YOUR_LARAVEL_ENDPOINT_URL' with the actual URL of your Laravel endpoint
    final String url = 'YOUR_LARAVEL_ENDPOINT_URL';

    // Replace 'YOUR_AUTHORIZATION_TOKEN' with any token or key required by your Laravel endpoint for authentication
    final String authorizationToken = 'YOUR_AUTHORIZATION_TOKEN';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: '{"token": "$token", "title": "$title", "body": "$body"}',
      );

      if (response.statusCode == 200) {
        print('FCM token and notification data sent to Laravel endpoint successfully.');
      } else {
        print('Failed to send FCM token and notification data to Laravel endpoint.');
      }
    } catch (e) {
      print('Error sending FCM token and notification data: $e');
    }
  }


  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Handle the received notification in the background as needed

    // If you want to show a notification when the app is in the background or terminated, use flutter_local_notifications

    // Initialize FlutterLocalNotificationsPlugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Define the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Replace 'your_channel_id' with a unique channel ID
      'Your Channel Name', // Replace 'Your Channel Name' with a channel name for the notification
      // 'Your Channel Description', // Replace 'Your Channel Description' with a channel description for the notification
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      0, // Replace with a unique ID for each notification if needed
      message.notification!.title, // Title of the notification received from Firebase
      message.notification!.body, // Body of the notification received from Firebase
      platformChannelSpecifics,
    );
  }

}
