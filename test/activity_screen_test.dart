import 'package:WaterWise/ui/activity_screen/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ActivityScreen should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ActivityScreen(),
      ),
    );

    // Verify that the widgets are rendered correctly
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsWidgets);

    // Add more widget assertions as needed
  });

  testWidgets('PdfViewerScreen should navigate back when the back button is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PdfViewerScreen(pdfFilePath: 'C:/Users/asus/Downloads/fyp steps.pdf'),
      ),
    );

    // // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    //
    // // Verify that PdfViewerScreen is popped from the navigation stack
    expect(find.byType(PdfViewerScreen), findsNothing);
    expect(find.byType(ActivityScreen), findsOneWidget);

    // Add more assertions for ActivityScreen as needed
  });
}
