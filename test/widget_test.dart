import 'package:flutter_test/flutter_test.dart';
import 'package:spiders_sensor/main.dart';

void main() {
  testWidgets('Player chooses Rock and sees result',
          (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Choose your move:'), findsOneWidget);

    await tester.tap(find.text('Rock'));
    await tester.pump();

    expect(find.textContaining('You chose: Rock'), findsOneWidget);

    expect(find.textContaining('You Win!').evaluate().isNotEmpty ||
        find.textContaining('You Lose!').evaluate().isNotEmpty ||
        find.textContaining('Draw').evaluate().isNotEmpty, true,);
  });
}
