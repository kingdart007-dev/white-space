import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Dark'), findsOneWidget);
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

  test('theme and locale preferences survive provider recreation', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await SharedPreferences.getInstance();
    final firstContainer = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(storage)],
    );
    final notifier = firstContainer.read(appPreferencesProvider.notifier);

    notifier.setLocale(const Locale('ar'));
    notifier.setThemeMode(ThemeMode.dark);
    await Future<void>.delayed(Duration.zero);
    await storage.reload();
    firstContainer.dispose();

    final secondContainer = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(storage)],
    );
    addTearDown(secondContainer.dispose);

    expect(
      secondContainer.read(appPreferencesProvider).locale,
      const Locale('ar'),
    );
    expect(
      secondContainer.read(appPreferencesProvider).themeMode,
      ThemeMode.dark,
    );
  });

  test('preference updates preserve unrelated settings', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appPreferencesProvider.notifier);
    notifier.setLocale(const Locale('ar'));
    notifier.setThemeMode(ThemeMode.dark);

    expect(container.read(appPreferencesProvider).locale, const Locale('ar'));
    expect(container.read(appPreferencesProvider).themeMode, ThemeMode.dark);

    notifier.setLocale(const Locale('en'));
    expect(container.read(appPreferencesProvider).themeMode, ThemeMode.dark);
  });
}
