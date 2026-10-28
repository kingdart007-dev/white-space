import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:white_space/app/app_preferences.dart';
import 'package:white_space/app/white_space_app.dart';

void main() {
  testWidgets('foundation home renders in English by default', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    expect(find.text('White Space'), findsOneWidget);
    expect(find.text('Room to think clearly.'), findsOneWidget);
    expect(find.text('THE FLUTTER FOUNDATION'), findsOneWidget);
  });

  testWidgets('language control switches to Arabic and RTL', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();

    expect(find.text('وايت سبيس'), findsOneWidget);
    expect(find.text('مساحة للتفكير بوضوح.'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('مساحة للتفكير بوضوح.'))),
      TextDirection.rtl,
    );
  });

  testWidgets('theme selection can be changed', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    await tester.dragUntilVisible(
      find.text('Dark'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('system theme is the initial theme preference', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.system);
  });

  test('preference updates preserve unrelated settings', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appPreferencesProvider.notifier);
    notifier.setLocale(const Locale('ar'));
    notifier.setThemeMode(ThemeMode.dark);

    expect(
      container.read(appPreferencesProvider).locale,
      const Locale('ar'),
    );
    expect(
      container.read(appPreferencesProvider).themeMode,
      ThemeMode.dark,
    );

    notifier.setLocale(const Locale('en'));
    expect(container.read(appPreferencesProvider).themeMode, ThemeMode.dark);
  });
}
