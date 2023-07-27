import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationSender {

  static Future<void> sendNotificationToLaravel(String token, String title, String body) async {
    // Replace 'YOUR_LARAVEL_ENDPOINT_URL' with the actual URL of your Laravel endpoint
    String url= "http://192.168.1.12:8000/api/sendMessage/";

    try {
      final response = await http.post(Uri.parse(url), body: {
        'regis': token.toString(),
        'title': title.toString(),
        'body' : body.toString(),
      });

      if (response.statusCode == 200) {
        print('Notification data sent to Laravel endpoint successfully.');
      } else {
        print('Failed to send notification data to Laravel endpoint.');
      }
    } catch (e) {
      print('Error sending notification data: $e');
    }
  }
}
