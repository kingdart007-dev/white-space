import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:white_space/core/design_system/components/app_feedback_state.dart';

void main() {
  testWidgets('empty state shows content and optional action', (tester) async {
    var actionCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppEmptyState(
            title: 'Nothing here yet',
            message: 'Add your first item to get started.',
            actionLabel: 'Add item',
            onAction: () => actionCalled = true,
          ),
        ),
      ),
    );

    expect(find.text('Nothing here yet'), findsOneWidget);
    expect(find.text('Add your first item to get started.'), findsOneWidget);
    await tester.tap(find.text('Add item'));
    expect(actionCalled, isTrue);
  });

  testWidgets('error state offers a working retry action', (tester) async {
    var retryCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppErrorState(
            title: 'Could not load items',
            message: 'Please try again.',
            retryLabel: 'Retry',
            onRetry: () => retryCalled = true,
          ),
        ),
      ),
    );

    expect(find.text('Could not load items'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retryCalled, isTrue);
  });
}
