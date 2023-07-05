import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WaterWise/ui/notification_screen/notification_screen.dart';

void main() {
  testWidgets('NotificationScreen Widget Test', (WidgetTester tester) async {
    // Wrap the NotificationScreen widget with a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: NotificationScreen(),
        ),
      ),
    );

    // Verify the presence of certain widgets
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    // expect(find.byType(Container), findsNWidgets(1)); // Update the expectation to findsOneWidget
    expect(find.byType(Text), findsNWidgets(1));
  });
}
