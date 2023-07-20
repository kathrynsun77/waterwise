import 'package:WaterWise/ui/receipt_marketplace_screen/receipt_marketplace_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Receipt Marketplace Screen Widget Test', (WidgetTester tester) async {
    // Build our ReceiptMarketplaceScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: ReceiptMarketplaceScreen(orderId: 1), // Replace 123 with a valid order ID
    ));

    // Test the existence of widgets in the screen.
    expect(find.text('Order Details'), findsOneWidget);
    expect(find.byType(CustomImageView), findsNWidgets(1));
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(CustomButton), findsOneWidget);

  });
}
