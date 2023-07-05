import 'package:WaterWise/ui/payment_methods_screen/payment_methods_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PaymentMethodScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PaymentMethodsScreen()));

    // Verify the presence of required widgets
    expect(find.text("Payment Methods"), findsOneWidget);
    expect(find.text("Bank Name"), findsOneWidget);
    expect(find.text("Card Number"), findsOneWidget);
    expect(find.text("Expiry Date"), findsOneWidget);
    expect(find.text("CVV"), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    // Enter text into the text fields
    final bankNameField = find.byType(CustomTextFormField).first;
    final cardNumberField = find.byType(CustomTextFormField).at(1);
    final expiryDateField = find.byType(CustomTextFormField).at(2);
    final cvvField = find.byType(CustomTextFormField).last;
    // await tester.enterText(bankNameField, 'Test Bank');
    // await tester.enterText(cardNumberField, '1234567890123456');
    // await tester.enterText(expiryDateField, '12/25');
    // await tester.enterText(cvvField, '123');


    // // Tap on the Add button
    // final addButton = find.text("Add");
    // await tester.tap(addButton);
    // await tester.pump();

  });

}
