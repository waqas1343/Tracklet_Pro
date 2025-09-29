import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracklet_pro/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const TrackletApp());

    // Verify the root MaterialApp is present (stable assertion without changing UI)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
