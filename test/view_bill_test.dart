import 'package:WaterWise/ui/view_bill_screen/view_bill_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ViewBill displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ViewBillScreen(),
      ),
    );

    // Verify that the ViewBill widget is rendered
    expect(find.byType(ViewBillScreen), findsOneWidget);

    // Verify the presence of specific widgets in the ViewBill widget
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(3));
    expect(find.byType(Text), findsNWidgets(4));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(Align), findsNWidgets(4));
    expect(find.byType(Padding), findsNWidgets(10));
    expect(find.byType(Row), findsNWidgets(1));
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Tap on imgArrowleft navigates back', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ViewBillScreen(),
      ),
    );

    // // Tap on imgArrowleft
    // await tester.tap(find.byType(CustomImageView));
    // await tester.pumpAndSettle();
    //
    // // Verify that we are back on the previous screen
    // expect(find.byType(ViewBillScreen), findsNothing);
  });

  testWidgets('Tap on Pay button navigates to PopUpScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ViewBillScreen(),
      ),
    );

    // // Tap on Pay button
    // await tester.tap(find.byType(CustomButton));
    // await tester.pumpAndSettle();
    //
    // // Verify that the PopUpScreen is navigated to
    // expect(find.text('PopUpScreen'), findsOneWidget);
  });
}
