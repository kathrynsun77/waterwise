import 'package:WaterWise/ui/splash_screen/starting_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WaterWise/ui/intro_screen/intro_screen.dart';

void main() {
  testWidgets('SplashScreenPage should navigate to IntroScreen after a certain duration',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: SplashScreenPage(),
            routes: {
              IntroScreen.routeName: (context) => IntroScreen(),
            },
          ),
        );

        // Wait for the duration of the splash screen
        await tester.pump(const Duration(seconds: 3));

        // Verify that IntroScreen is pushed onto the navigation stack
        expect(find.byType(IntroScreen), findsOneWidget);
        // Add more assertions for IntroScreen as needed
      });
}

