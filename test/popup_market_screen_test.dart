import 'package:WaterWise/ui/popup_marketplace_screen/popup_marketplace_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Popup Marketplace Screen Widget Test', (WidgetTester tester) async {
    // Build our PopupMarketplaceScreen widget.
    await tester.pumpWidget(MaterialApp(home: PopupMarketplaceScreen()));

    // Test the existence of widgets in the screen.
    expect(find.text('Payment Summary'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField), findsNWidgets(2));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

  });
}
