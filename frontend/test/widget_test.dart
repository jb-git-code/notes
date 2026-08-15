// This is a basic smoke test to verify the app builds without crashing.
//
// For more information on testing widgets, see:
// https://docs.flutter.dev/cookbook/testing/widget/introduction

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

import 'package:frontend/core/local/hive_boxes.dart';
import 'package:frontend/main.dart';

void main() {
  setUp(() async {
    // Sets up an in-memory Hive instance for tests, so we don't touch
    // the real on-disk database and don't need path_provider mocking.
    await setUpTestHive();

    // Open every box the app expects to already be open by the time
    // MyApp builds. If a box stores a custom typed object (e.g. NoteMeta),
    // its Hive TypeAdapter must be registered here too — otherwise
    // this open call (or a later typed access) will throw.
    await Hive.openBox(HiveBoxes.noteMeta);
    await Hive.openBox(HiveBoxes.settings);
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // Wrap MyApp in a ProviderScope since the app uses Riverpod for state
    // management. Without this, any widget that calls ref.watch/ref.read
    // will throw "Bad state: No ProviderScope found".
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Just verify the app renders without throwing any exceptions.
    // Add more specific widget assertions here as your test suite grows.
    expect(tester.takeException(), isNull);
  });
}