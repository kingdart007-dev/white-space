import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:white_space/core/design_system/components/app_selection_tile.dart';

void main() {
  testWidgets('shows title, subtitle, and selected state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSelectionTile(
            title: 'Dark appearance',
            subtitle: 'Use a darker interface',
            selected: true,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Dark appearance'), findsOneWidget);
    expect(find.text('Use a darker interface'), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(AppSelectionTile)),
      matchesSemantics(
        isButton: true,
        isSelected: true,
        hasEnabledState: true,
        isEnabled: true,
      ),
    );
  });

  testWidgets('tap invokes callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSelectionTile(
            title: 'Light appearance',
            selected: false,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Light appearance'));
    expect(tapped, isTrue);
  });

  testWidgets('disabled tile does not invoke callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSelectionTile(
            title: 'Unavailable option',
            selected: false,
            enabled: false,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Unavailable option'));
    expect(tapped, isFalse);
  });
}
