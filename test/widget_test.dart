import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:white_space/app/white_space_app.dart';

void main() {
  testWidgets('foundation home renders in English by default', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    expect(find.text('White Space'), findsOneWidget);
    expect(find.text('Room to think clearly.'), findsOneWidget);
    expect(find.text('THE FLUTTER FOUNDATION'), findsOneWidget);
  });

  testWidgets('language control switches the screen to Arabic', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();

    expect(find.text('وايت سبيس'), findsOneWidget);
    expect(find.text('مساحة للتفكير بوضوح.'), findsOneWidget);
  });

  testWidgets('theme selection can be changed', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: WhiteSpaceApp()));

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });
}
