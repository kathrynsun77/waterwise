import 'package:WaterWise/app_bar/custom_app_bar.dart';
import 'package:WaterWise/ui/orders_screen/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Orders Screen Widget Test', (WidgetTester tester) async {
    // Build our OrdersScreen widget.
    await tester.pumpWidget(MaterialApp(home: OrdersScreen()));

    // Test the existence of widgets in the screen.
    expect(find.text('My Orders'), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

  });
}
