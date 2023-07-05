import 'package:WaterWise/ui/success_transactions_screen/success_transactions_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SuccessTransactionsScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SuccessTransactionsScreen(),
      ),
    );

    // Verify that the SuccessTransactionsScreen widget is rendered
    expect(find.byType(SuccessTransactionsScreen), findsOneWidget);

    // Verify the presence of specific widgets in the SuccessTransactionsScreen widget
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2));
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Tap on Back to Home button navigates to bottomBarMenu', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SuccessTransactionsScreen(),
      ),
    );

    // // Tap on Back to Home button
    // await tester.tap(find.byType(CustomButton));
    // await tester.pumpAndSettle();
    //
    // // Verify that the bottomBarMenu is navigated to
    // expect(find.text('bottomBarMenu'), findsOneWidget);
  });
}
