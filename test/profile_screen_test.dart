import 'package:WaterWise/app_bar/custom_app_bar.dart';
import 'package:WaterWise/ui/profile_screen/profile_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Create a mock MaterialApp for testing
  Widget createProfileScreen() {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }

  testWidgets('Profile screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createProfileScreen());

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(CustomButton), findsNWidgets(5));
  });
}
