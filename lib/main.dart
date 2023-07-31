import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:WaterWise/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fcm_handler.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

Future<void> showNotification() async {
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
    'Notification Title',
    'Notification Body',
    platformChannelSpecifics,
  );
}

//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // Initialize FlutterLocalNotificationsPlugin
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon');
//   final InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
// // Get the FCM token
//   String? fcmToken = await FirebaseMessaging.instance.getToken();
//   print('FCM Token: $fcmToken');
//
// // Configure Firebase messaging
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   // Send notification data to Laravel when needed
//   if (fcmToken != null) {
//     NotificationSender.sendNotificationToLaravel(fcmToken, "abc", "abcd");
//   }
//
//   runApp(MyApp());
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling a background message: ${message.messageId}');
//   print('Notification title: ${message.notification!.title}');
//   print('Notification body: ${message.notification!.body}');
//
//   // Initialize FlutterLocalNotificationsPlugin
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // Define the notification details
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'water_wise_1', // Replace with your notification channel ID
//     'water_wise_1', // Replace with your channel name
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//
//   const NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   // Show the notification
//   await flutterLocalNotificationsPlugin.show(
//     0, // Replace with a unique ID for each notification if needed
//     message.notification!.title!, // Title of the notification received from Firebase
//     message.notification!.body!, // Body of the notification received from Firebase
//     platformChannelSpecifics,
//   );
//
//   print("Ini test Notif $firebaseMessagingBackgroundHandler");
// }

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