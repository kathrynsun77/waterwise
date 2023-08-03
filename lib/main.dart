import 'dart:math';
import 'package:flutter/material.dart';
import 'package:WaterWise/routes/app_routes.dart';
// import '../ui/notification_screen/notification_screen.dart';
import '../../API.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi plugin notifikasi lokal
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> billDue() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'channel_id', // ID unik untuk channel notifikasi
    'water_wise_1', // Nama channel notifikasi
    // 'channel_description', // Deskripsi channel notifikasi
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
  IOSNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // Menampilkan notifikasi dengan ID unik 0
  await flutterLocalNotificationsPlugin.show(
    0,
    'Water Bill Due',
    'Monthly Water Bill Due',
    platformChannelSpecifics,
  );
  addToNotif('Water Bill Due', 'Monthly Water Bill Due');
}

Future<void> highUsage() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'channel_id', // ID unik untuk channel notifikasi
    'water_wise_1', // Nama channel notifikasi
    // 'channel_description', // Deskripsi channel notifikasi
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
  IOSNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // Menampilkan notifikasi dengan ID unik 0
  await flutterLocalNotificationsPlugin.show(
    0,
    'High Usage Detected',
    'Check your pipe status on activity page',
    platformChannelSpecifics,
  );
  addToNotif('High Usage Detected', 'Check your pipe status on activity page');

}

Future<void> serviceNot() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'channel_id', // ID unik untuk channel notifikasi
    'water_wise_1', // Nama channel notifikasi
    // 'channel_description', // Deskripsi channel notifikasi
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
  IOSNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // Menampilkan notifikasi dengan ID unik 0
  await flutterLocalNotificationsPlugin.show(
    0,
    'Household Pipe Free Service/Check',
    'Please contact us if you do need service',
    platformChannelSpecifics,
  );
  addToNotif('Household Pipe Free Service/Check', 'Please contact us if you do need service');

}

Future<void> waterSaving() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'channel_id', // Unique ID for the notification channel
    'water_wise_1', // Notification channel name
    // 'channel_description', // Notification channel description
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
  IOSNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // List of random texts
  List<String> randomTexts = [
    "Remember to turn off the faucet while brushing your teeth.",
    "Fix any leaking pipes or faucets to save water.",
    "Use a broom instead of a hose to clean driveways and sidewalks.",
    "Collect rainwater for your plants and garden.",
    "Take shorter showers to conserve water.",
  ];

  // Randomly select a text from the list
  Random random = Random();
  String randomText = randomTexts[random.nextInt(randomTexts.length)];
  String text = randomText;

  // Show notification with the randomly selected text
  await flutterLocalNotificationsPlugin.show(
    0,
    'Weekly Water Saving Advice',
    text,
    platformChannelSpecifics,
  );

  addToNotif('Weekly Water Saving Advice', 'text');

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'water_wise_1', // Replace with your desired channel ID
      'water_wise_1', // Replace with your desired channel name
      importance: Importance.high,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
      ),
      title: 'WaterWise',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}