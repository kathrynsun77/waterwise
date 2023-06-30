import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:WaterWise/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
//   FirebaseOptions firebaseOptions = FirebaseOptions(
//     appId: '1:669869517366:android:5d18273382c18c601d8697',
//     apiKey: 'AIzaSyBdexCLY8cWiF96Rn429D8pJH_bWpzDKKE',
//     projectId: 'waterwise-ac997',
//     messagingSenderId: '669869517366',
//     // Other options...
//   );
//   await Firebase.initializeApp(
//     options: firebaseOptions
//   );
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
//   final fcmToken = await FirebaseMessaging.instance.getToken();
// print (fcmToken);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
