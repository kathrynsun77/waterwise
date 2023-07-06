import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:WaterWise/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

main()  async {
  String API= "http://10.33.133.168/water_wise/";
  WidgetsFlutterBinding.ensureInitialized();;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken1 = await FirebaseMessaging.instance.getToken();
    final response = await http.post(
        Uri.parse(API+'sendMessage'),
        body: {
          'regis': fcmToken1.toString(),
        });
    if (response.statusCode == 200) {
      // Decode the JSON response
      print ('token: ${fcmToken1}');
      print(response.body);
    }
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
