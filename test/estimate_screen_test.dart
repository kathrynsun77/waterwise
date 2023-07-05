import 'package:WaterWise/ui/estimate_screen/estimate_screen.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_image_view.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EstimateScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstimateScreen(),
      ),
    );

    // Verify the initial state of the widget
    expect(find.text('Your Usage Estimation'), findsOneWidget);
    expect(find.byType(CustomImageView), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    // Perform tap on the 'Manual Estimation' button
    await tester.tap(find.text('Manual \nEstimation'));
    await tester.pump();

    // Perform tap on the 'Estimate' button
    await tester.tap(find.text('Estimate'));
    await tester.pump();

    // Perform tap on the 'Arrow Left' button
    await tester.tap(find.byType(CustomImageView));
    await tester.pump();
  });
}
