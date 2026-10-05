import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirastec/main.dart';

void main() {
  testWidgets('La aplicación se inicializa correctamente con ProviderScope', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AplicacionMirastec(),
      ),
    );
    expect(find.text('MIRASTEC'), findsAtLeastNWidgets(1));
  });
}
