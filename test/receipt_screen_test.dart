import 'package:WaterWise/ui/receipt_screen/receipt_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Create a mock MaterialApp for testing
  Widget createReceiptScreen() {
    return MaterialApp(
      home: ReceiptScreen(),
    );
  }

  testWidgets('Receipt screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createReceiptScreen());

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

}
