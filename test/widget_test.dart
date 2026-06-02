import 'package:flutter_test/flutter_test.dart';

import 'package:pamits_bmi_app/main.dart';

void main() {
  testWidgets('PAMITS BMI APP loads input page', (WidgetTester tester) async {
    await tester.pumpWidget(const PamitsBMIApp());

    expect(find.text('PAMITS BMI APP'), findsOneWidget);
    expect(find.text('MALE'), findsOneWidget);
    expect(find.text('FEMALE'), findsOneWidget);
    expect(find.text('CALCULATE'), findsOneWidget);
  });
}
