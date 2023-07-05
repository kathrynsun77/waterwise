import 'package:WaterWise/ui/activity_trends_screen/activity_trends_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ActivityScreenTrends', ()
  {
    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ActivityTrendsScreen(),
        ),
      );

      // Verify that the widgets are rendered correctly
      expect(find.byType(SafeArea), findsNWidgets(2));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(RefreshIndicator), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });


    testWidgets(
        'PdfViewerScreen should navigate back when the back button is tapped', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PdfViewerScreen(pdfFilePath: 'C:/Users/asus/Downloads/fyp steps.pdf'),
        ),
      );

      // Tap the back button
      // await tester.tap(find.byIcon(Icons.arrow_back));
      // await tester.pumpAndSettle();

      // Verify that PdfViewerScreen is popped from the navigation stack
      // expect(find.byType(PdfViewerScreen), findsNothing);
      // expect(find.byType(ActivityTrendsScreen), findsOneWidget);
      // Add more assertions for ActivityScreen as needed
    });

    testWidgets(
        'should navigate to ActivityScreen when "Usage" button is tapped', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ActivityTrendsScreen(),
        ),
      );

      // Tap the "Usage" button
      // await tester.tap(find.text('Usage'));
      // await tester.pumpAndSettle();

      // Verify that ActivityScreen is pushed onto the navigation stack
      // expect(find.byType(ActivityScreen), findsNothing);
      // Add more assertions for ActivityScreen as needed
    });
  }
  );
}