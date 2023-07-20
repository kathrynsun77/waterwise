import 'package:WaterWise/ui/productdetails_screen/productdetails_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Product Details Screen Widget Test', (WidgetTester tester) async {
    // Build our ProductdetailsScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: ProductdetailsScreen(productId: 1),
    ));

    // Test the existence of widgets in the screen.
    expect(find.text('Product Name'), findsOneWidget);
    expect(find.byType(CustomImageView), findsNWidgets(2));
    expect(find.byType(Divider), findsNWidgets(2));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.byType(CustomButton), findsOneWidget);

  });
}
