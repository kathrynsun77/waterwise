import 'package:WaterWise/app_bar/custom_app_bar.dart';
import 'package:WaterWise/ui/marketplace_screen/marketplace_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Marketplace Screen Widget Test', (WidgetTester tester) async {
    // Build our MarketplaceScreen widget.
    await tester.pumpWidget(MaterialApp(home: MarketplaceScreen()));

    // Test the existence of widgets in the screen.
    expect(find.text('Marketplace'), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

  });
}
