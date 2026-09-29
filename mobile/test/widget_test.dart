import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sidequest/app/app.dart';
import 'package:sidequest/core/game/progression.dart';

void main() {
  test('progression formula', () {
    expect(Progression.levelFromXp(0), 1);
    expect(Progression.levelFromXp(100), 2);
    expect(Progression.levelFromXp(299), 2);
    expect(Progression.levelFromXp(300), 3);
  });

  testWidgets('bottom navigation switches sections', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SideQuestApp()));
    await tester.pumpAndSettle();
    expect(find.text('Hola, explorador'), findsOneWidget);
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('Aquí irán tu nivel, insignias e historial.'), findsOneWidget);
  });
}
