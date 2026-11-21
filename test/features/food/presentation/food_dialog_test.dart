import 'package:dog_app/features/food/domain/food.dart';
import 'package:dog_app/features/food/presentation/food_dialog.dart';
import 'package:dog_app/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('edit dialog fits a small screen with the keyboard open', (
    tester,
  ) async {
    // Phone-sized screen with a ~300 px keyboard.
    tester.view.physicalSize = const Size(1080, 1900);
    tester.view.devicePixelRatio = 3;
    tester.view.viewInsets = const FakeViewPadding(bottom: 900);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pl'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => showFoodDialog(
                  context,
                  initial: const Food(id: 'f1', name: 'Adult', brand: 'Acana'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('foodName')), findsOneWidget);
    // The last field can be scrolled into view.
    await tester.ensureVisible(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
