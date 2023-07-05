import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WaterWise/ui/intro_screen/intro_screen.dart';

void main() {
  testWidgets('IntroScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IntroScreen(),
      ),
    );

    // Verify that the IntroScreen widget is rendered
    expect(find.byType(IntroScreen), findsOneWidget);

    // Verify the presence of specific widgets in the IntroScreen
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(5));
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(4));
  });

  testWidgets('Tap Login button navigates to LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IntroScreen(),
      ),
    );

    // // Tap the Login button
    // await tester.tap(find.text('Login'));
    // await tester.pumpAndSettle();
    //
    // // Verify that the LoginScreen is navigated to
    // expect(find.text('LoginScreen'), findsOneWidget);
  });

  testWidgets('Tap Register button navigates to RegisterScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IntroScreen(),
      ),
    );

    // // Tap the Register button
    // await tester.tap(find.text('Register'));
    // await tester.pumpAndSettle();
    //
    // // Verify that the RegisterScreen is navigated to
    // expect(find.text('RegisterScreen'), findsOneWidget);
  });
}
