import 'package:flutter_test/flutter_test.dart';
import 'package:speedeco/main.dart';

void main() {
  testWidgets('SpeedEco app renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SpeedEcoApp());
    await tester.pump();

    expect(find.text('SpeedEco'), findsOneWidget);
    expect(find.text('Go Fast, Stay Green'), findsOneWidget);

    // Advance past the splash screen timer to avoid pending timer assertion
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
