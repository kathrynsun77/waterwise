import 'package:WaterWise/app_bar/custom_app_bar.dart';
import 'package:WaterWise/routes/app_routes.dart';
import 'package:WaterWise/ui/home/home__screen.dart';
import 'package:WaterWise/widget/custom_icon_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('Verify widgets in HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          AppRoutes.estimateScreen: (context) => Placeholder(),
          AppRoutes.activityScreen: (context) => Placeholder(),
        },
        home: HomeScreen(),
      ));

      // Verify the existence of specific widgets

      expect(find.byType(SafeArea), findsNWidgets(2));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(RefreshIndicator), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ListView), findsNWidgets(2));
      expect(find.byType(Align), findsNWidgets(7));
      expect(find.byType(Padding), findsNWidgets(28));
      expect(find.byType(Text), findsNWidgets(7));
      expect(find.byType(CustomIconButton), findsNWidgets(2));
      expect(find.byType(CustomImageView), findsNWidgets(3));
      expect(find.byType(GestureDetector), findsNWidgets(11));
      expect(find.byType(Row), findsNWidgets(3));
    });

    testWidgets('Tap on water widget navigates to estimate screen',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            routes: {
              AppRoutes.estimateScreen: (context) => Placeholder(),
              AppRoutes.activityScreen: (context) => Placeholder(),
            },
            home: HomeScreen(),
          ));

          // await tester.tap(find.byKey(Key('waterWidget')));
          // await tester.pumpAndSettle();
          //
          // expect(find.byType(Placeholder), findsOneWidget);
        });

    testWidgets('Tap on invest widget navigates to activity screen',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            routes: {
              AppRoutes.estimateScreen: (context) => Placeholder(),
              AppRoutes.activityScreen: (context) => Placeholder(),
            },
            home: HomeScreen(),
          ));

          // await tester.tap(find.byKey(Key('investWidget')));
          // await tester.pumpAndSettle();
          //
          // expect(find.byType(Placeholder), findsOneWidget);
        });

    testWidgets('Tap on small label navigates to activity screen',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            routes: {
              AppRoutes.estimateScreen: (context) => Placeholder(),
              AppRoutes.activityScreen: (context) => Placeholder(),
            },
            home: HomeScreen(),
          ));

          // await tester.tap(find.byKey(Key('smallLabel')));
          // await tester.pumpAndSettle();
          //
          // expect(find.byType(Placeholder), findsOneWidget);
        });
  });
}
