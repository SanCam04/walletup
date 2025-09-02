// This is a basic Flutter widget test for WalletUp app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:walletup/app/app.dart';

void main() {
  testWidgets('WalletUp app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: WalletUpApp()));

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app loads with wallet page.
    expect(find.text('My Wallets'), findsOneWidget);

    // Wait for loading to complete and check for empty state
    await tester.pumpAndSettle();
    expect(find.text('No wallets yet'), findsOneWidget);
    expect(
      find.text('Create your first wallet to get started'),
      findsOneWidget,
    );

    // Verify that floating action button exists.
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
