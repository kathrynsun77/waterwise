import 'package:WaterWise/ui/login_screen/login_screen.dart';
import 'package:WaterWise/ui/sign_up_screen/sign_up_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Create a mock MaterialApp for testing
  Widget createSignUpScreen() {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }

  testWidgets('Sign up screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createSignUpScreen());

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(4));
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.byType(RichText), findsOneWidget);
  });

  testWidgets('Tapping sign in text navigates to sign-in screen',
          (WidgetTester tester) async {
        await tester.pumpWidget(createSignUpScreen());

        // Tap the sign-in text
        await tester.tap(find.text('Sign In'));
        await tester.pumpAndSettle();

        // Verify that the sign-in screen is navigated to
        expect(find.byType(LoginScreen), findsOneWidget);
      });
}
