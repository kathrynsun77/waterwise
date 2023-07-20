import 'package:WaterWise/ui/manage_address_screen/manage_address_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Manage Address Screen Widget Test', (WidgetTester tester) async {
    // Build our ManageAddressScreen widget.
    await tester.pumpWidget(MaterialApp(home: ManageAddressScreen()));

    // Test the existence of widgets in the screen.
    expect(find.text('Delivery Address'), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(4));
    expect(find.byType(CustomButton), findsOneWidget);
  });
}
