import 'package:WaterWise/ui/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Verify the presence of required widgets
    expect(find.text("Welcome Back,"), findsOneWidget);
    expect(find.text("Login to continue your journey"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);

    // Verify the initial values of TextEditingControllers
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    final emailController = tester.widget<TextFormField>(emailField).controller;
    final passwordController = tester.widget<TextFormField>(passwordField).controller;
    expect(emailController?.text, '');
    expect(passwordController?.text, '');

    // Enter text into email and password fields
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');

    // Verify that the text is updated in the TextEditingControllers
    expect(emailController?.text, 'test@example.com');
    expect(passwordController?.text, 'password123');

    // // Tap on the login button
    // final loginButton = find.byType(CustomButton);
    // await tester.tap(loginButton);
    // await tester.pump();

  });
}
