import 'package:WaterWise/ui/vouchers_screen/vouchers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Points Widget Test', (WidgetTester tester) async {
    // Wrap the VouchersScreen widget with a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: VouchersScreen(),
      ),
    );

    // Verify the presence of certain widgets
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SafeArea), findsNWidgets(2));
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}