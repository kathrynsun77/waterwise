import 'package:WaterWise/ui/popup_screen/popup_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PaymentSummaryScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PopupScreen()));

    // Verify the presence of required widgets
    expect(find.byType(DropdownButtonFormField), findsOneWidget);
    expect(find.text("Amount+GST(8%)"), findsOneWidget);
    expect(find.text("Admin Fee"), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text("Total"), findsOneWidget);
    expect(find.text("Make Payment"), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

  });

}
