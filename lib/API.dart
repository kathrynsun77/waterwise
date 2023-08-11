// API.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String API= "https://api.waterwise-app.com/";

Map user = {};

getUser() async {
  final pref = await SharedPreferences.getInstance();
  String? userString = pref.getString("user");
  if (userString != null) {
    user = jsonDecode(userString);
  }
}

addToNotif(String title, String body) async {
  getUser();
  final response = await http.post(
      Uri.parse(API+'add_notif.php'),
      body: {
        'title': title.toString(),
        'body': body.toString(),
        'cust-id': user['customer_id'].toString(),
      });
  // print('fetched');
  if (response.statusCode == 200) {
    // Decode the JSON response
    print(response.body);
  } else {
    throw Exception('Failed to fetch data');
  }
}
