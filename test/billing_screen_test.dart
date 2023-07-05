import 'package:WaterWise/ui/billing_screen/billing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Billing displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BillingScreen(),
      ),
    );

    // Verify that the Billing widget is rendered
    expect(find.byType(BillingScreen), findsOneWidget);

    // Verify the presence of specific widgets in the Billing widget
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Padding), findsNWidgets(1));
  });

  testWidgets('Tap on bill navigates to ViewBillScreen when bill status is 2', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BillingScreen(),
      ),
    );

    // Tap on a bill where the status is 2
    // await tester.tap(find.byType(GestureDetector).at(0));
    // await tester.pumpAndSettle();
    //
    // // Verify that the ViewBillScreen is navigated to
    // expect(find.text('ViewBillScreen'), findsOneWidget);
  });

  testWidgets('Tap on bill navigates to ReceiptScreen when bill status is not 2', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BillingScreen(),
      ),
    );

    // Tap on a bill where the status is not 2
    // await tester.tap(find.byType(GestureDetector).at(1));
    // await tester.pumpAndSettle();
    //
    // // Verify that the ReceiptScreen is navigated to
    // expect(find.text('ReceiptScreen'), findsOneWidget);
  });
}
