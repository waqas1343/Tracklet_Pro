import 'package:flutter_test/flutter_test.dart';
import 'package:tracklet_pro/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const TrackletApp());

    // Verify the app title is shown
    expect(find.text('Tracklet Pro App'), findsOneWidget);
  });
}
