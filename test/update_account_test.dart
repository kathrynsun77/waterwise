import 'package:WaterWise/ui/update_account_screen/update_account_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Create a mock MaterialApp for testing
  Widget createUpdateScreen() {
    return MaterialApp(
      home: UpdateAccountScreen(),
    );
  }

  testWidgets('Update screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createUpdateScreen());

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(3));
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Tapping back arrow image pops the screen',
          (WidgetTester tester) async {
        await tester.pumpWidget(createUpdateScreen());

        // Tap the back arrow image
        await tester.tap(find.byType(CustomImageView));
        await tester.pumpAndSettle();

        // Verify that the screen is popped
        expect(find.byType(UpdateAccountScreen), findsNothing);
      });
}
