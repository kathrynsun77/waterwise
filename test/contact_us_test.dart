import 'package:WaterWise/ui/contact_us_screen/contact_us_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ContactusScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContactUsScreen(),
      ),
    );

    // Verify the initial state of the widget
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Have a question about your water supply?'), findsOneWidget);
    expect(find.text('Email your company below to file your problems or complaints'), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('company-cust@company.com'), findsOneWidget);
    expect(find.text('+6582835537'), findsOneWidget);

    // // Perform tap on the 'Send' button
    // await tester.tap(find.text('Send'));
    // await tester.pump();

    // Verify the updated state after tapping the 'Send' button
    // You can add your own assertions here based on the expected behavior

    // Perform tap on the 'Contact Us' button
    await tester.tap(find.text('Contact Us'));
    await tester.pump();

    // Verify the updated state after tapping the 'Contact Us' button
    // You can add your own assertions here based on the expected behavior
  });
}
