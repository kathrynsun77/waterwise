import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

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
      await sendTokenToEndpoint(fcmToken);
    }
  }

  Future<void> sendTokenToEndpoint(String token) async {
    // Replace 'YOUR_LARAVEL_ENDPOINT_URL' with the actual URL of your Laravel endpoint
    final String url = 'YOUR_LARAVEL_ENDPOINT_URL';

    // Replace 'YOUR_AUTHORIZATION_TOKEN' with any token or key required by your Laravel endpoint for authentication
    final String authorizationToken = 'YOUR_AUTHORIZATION_TOKEN';

    try {
      final response = await http.post(Uri.parse(url), body: {
        'regis': token.toString(),
      });

      if (response.statusCode == 200) {
        print('FCM token sent to Laravel endpoint successfully.');
      } else {
        print('Failed to send FCM token to Laravel endpoint.');
      }
    } catch (e) {
      print('Error sending FCM token: $e');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Handle the received notification in the background as needed
  }
}
