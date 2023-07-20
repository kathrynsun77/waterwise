import 'package:WaterWise/ui/cart_screen/cart_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cart Screen Widget Test', (WidgetTester tester) async {
    // Build our CartScreen widget.
    await tester.pumpWidget(MaterialApp(home: CartScreen()));

    // Test the existence of widgets in the screen.
    expect(find.text('My cart'), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
  });
}
