import 'package:WaterWise/ui/billing_screen/billing_screen.dart';
import 'package:WaterWise/ui/bottom_bar/bottom_bar_menu.dart';
import 'package:WaterWise/ui/home/home__screen.dart';
import 'package:WaterWise/ui/notification_screen/notification_screen.dart';
import 'package:WaterWise/ui/profile_screen/profile_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('BottomBarMenu widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: BottomBarMenu(),
        ),
      ),
    );

    // Verify that the BottomNavyBar is displayed
    expect(find.byType(BottomNavyBar), findsOneWidget);

    // Verify that the initial screen is HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);

    // Tap on the second item in the BottomNavyBar
    // await tester.tap(find.byIcon(Icons.file_invoice_dollar_mco));
    await tester.pump();

    // Verify that the screen changes to BillingScreen
    expect(find.byType(BillingScreen), findsOneWidget);

    // Tap on the third item in the BottomNavyBar
    // await tester.tap(find.byIcon(Icons.bell_oct));
    await tester.pump();

    // Verify that the screen changes to NotificationScreen
    expect(find.byType(NotificationScreen), findsOneWidget);

    // Tap on the fourth item in the BottomNavyBar
    // await tester.tap(find.byIcon(Icons.user_outline));
    await tester.pump();

    // Verify that the screen changes to ProfileScreen
    expect(find.byType(ProfileScreen), findsOneWidget);
  });
}
