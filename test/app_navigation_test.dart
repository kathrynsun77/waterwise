import 'package:WaterWise/ui/app_navigation_screen/app_navigation_screen.dart';
import 'package:WaterWise/ui/intro_screen/intro_screen.dart';
import 'package:WaterWise/ui/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WaterWise/routes/app_routes.dart';

void main() {
  testWidgets('AppNavigationScreen should navigate to IntroScreen when "before login" is tapped',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppNavigationScreen(),
            routes: {
              AppRoutes.introScreen: (context) => IntroScreen(),
            },
          ),
        );

        // Tap the "before login" widget
        await tester.tap(find.text('before login'));
        await tester.pumpAndSettle();

        // Verify that IntroScreen is pushed onto the navigation stack
        expect(find.byType(IntroScreen), findsOneWidget);
        // Add more assertions for IntroScreen as needed
      });

  testWidgets('AppNavigationScreen should navigate to LoginScreen when "Login" is tapped',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppNavigationScreen(),
            routes: {
              AppRoutes.loginScreen: (context) => LoginScreen(),
            },
          ),
        );

        // Tap the "Login" widget
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        // Verify that LoginScreen is pushed onto the navigation stack
        expect(find.byType(LoginScreen), findsOneWidget);
        // Add more assertions for LoginScreen as needed
      });
}


